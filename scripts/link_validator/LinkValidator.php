<?php

class LinkValidator {
  private $link;
  private $domain;
  private $response;

  public function __construct($link, $domain = '') {
    $this->link = $link;
    $this->domain = $domain;
    $this->determine_request();
  }

  public function get_response() {
    return $this->response;
  }

  private function determine_request() {
    $curl = $this->do_request();

    if ($curl['info']['http_code'] == 200) {
      if (preg_match('/id="searchTips"/', $curl['contents'])) {
        $this->response = array(
          'type' => 'AOK',
          'http_code' => $curl['info']['http_code']
        ) + $curl['info'];
      }
      else {
        $this->response = array(
          'type' => 'AOK',
          'http_code' => $curl['info']['http_code']
        ) + $curl['info'];
      }
    }
    else if ($curl['info']['http_code'] == 301) {
      $values = explode("\n", $curl['contents']);

      foreach ($values as $value) {
        if (strstr($value, 'Location: ')) {
          $location_url = explode('Location: ', $value);
          $redirected_url = str_replace(array(' ', '"'), array('', '%22'), $location_url[1]);

          $this->determine_request($redirected_url);
        }
      }
    }
    else if (strstr($curl['info']['http_code'], 40) || strstr($curl['info']['http_code'], 50)) {
      $this->response = array(
        'type' => 'Bad Request',
        'http_code' => $curl['info']['http_code']
      ) + $curl['info'];
    }
    else {
      print "I need an adult?!?!?!? $link\n\n";
    }
  }

  private function do_request() {
    if (!strstr($this->link, 'http'))
      $this->link = $this->domain . $this->link;

    $ch = curl_init();

    curl_setopt_array($ch, array(CURLOPT_URL            => $this->link,
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
}

?>
