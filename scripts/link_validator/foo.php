<?php

$fp = fopen('footwear_scrape.csv', 'w');
fputcsv($fp, array('Page', 'Link', 'Status Code'));

include_once 'LinkValidator.php';

$pages = array(
  'Shoes' => 'http://www.zappos.com/shoes',
  'Clothing' => 'http://www.zappos.com/clothing'
);

$pattern = '/<a(?:[^>]*)href=\"([^\"]*)\"(?:[^>]*)>(?:[^<]*)<\/a>/is';

foreach ($pages as $page) {
  $page_output = file_get_contents($page);
  preg_match('/<\!-- \[content\] -->(.*)<\!-- \[\/content\] -->/s', $page_output, $matches);
  preg_match_all($pattern, $matches[0], $urls);

  foreach ($urls as $url) {
    $links = preg_replace($pattern, '$1', $url);

    foreach ($links as $link) {
      $link_validator = new LinkValidator($link, 'http://www.zappos.com');
      $response = $link_validator->get_response();
      fputcsv($fp, array($page, $link, $curl['info']['http_code']));
      print "$link\n";
    }
  }
}

fclose($fp);

?>

