<?php

define('QA_DOMAIN', 'http://qae6.zappos.com');
define('PROD_DOMAIN', 'http://www.zappos.com');
define('PAGE', 'includes/dropdowns.html');

$pattern = '/href="(.*)"/';

$page_output = file_get_contents(QA_DOMAIN . '/' . PAGE);

preg_match_all($pattern, $page_output, $urls);

$fp = fopen('dropdown-html-links.csv', 'w');
fputcsv($fp, array('Link', 'Type', 'Tested on Live', 'Status Code'));

$url_length = count($urls[0]);

$i = 1;
foreach ($urls[0] as $url) {
  $link = QA_DOMAIN . preg_replace($pattern, '$1', $url);

  print "Fetching $url ($i of $url_length)\n";
  determine_request_type($fp, $link);

  $i++;
}

fclose($fp);

function determine_request_type($fp, $link) {

  $curl = do_request($link);

  if ($curl['info']['http_code'] == 200) {
    if (preg_match('/id="searchTips"/', $curl['contents'])) {
      $link = str_replace(QA_DOMAIN, PROD_DOMAIN, $link);

      $curl = do_request($link);
      $link = str_replace(QA_DOMAIN, '', $link);
      if (preg_match('/id="searchTips"/', $curl['contents'])) {
        fputcsv($fp, array($link, 'No Results Page', 'N', $curl['info']['http_code']));
      } else {
        fputcsv($fp, array($link, 'AOK', 'Y', $curl['info']['http_code']));
      }
    }
    else {
      $link = str_replace(QA_DOMAIN, '', $link);
      fputcsv($fp, array($link, 'AOK', 'N', $curl['info']['http_code']));
    }
  }
  else if ($curl['info']['http_code'] == 301) {
    $values = explode("\n", $curl['contents']);

    foreach ($values as $value) {
      if (strstr($value, 'Location: ')) {
        $location_url = explode('Location: ', $value);
        $redirected_url = str_replace(array(' ', '"'), array('', '%22'), $location_url[1]);

        determine_request_type($fp, $redirected_url);
      }
    }
  }
  else if (strstr($curl['info']['http_code'], 40) || strstr($curl['info']['http_code'], 50)) {
    $link = str_replace(QA_DOMAIN, '', $link);
    fputcsv($fp, array($link, 'Bad News Dude', 'N', $curl['info']['http_code']));
  }
  else {
    print "I broke something?!?!?!? $link\n\n";
  }
}

function do_request($link) {
  $ch = curl_init();

  curl_setopt_array($ch, array(CURLOPT_URL            => $link,
                               CURLOPT_HEADER         => 1,
                               CURLOPT_RETURNTRANSFER => true,
                               CURLOPT_FOLLOWLOCATION => true,
                               CURLOPT_CONNECTTIMEOUT => 2));

  $contents = curl_exec($ch);
  $info = curl_getinfo($ch);
  curl_close($ch);

  return array(
    'contents' => $contents,
    'info' => $info
  );
}

?>
