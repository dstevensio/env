<?php

class LinkDeal {
  private $mysql;
  private $fp;

  public function __construct($host, $username, $password, $db, $filename) {
    $this->mysql = new mysqli($host, $username, $password, $db);
    $this->fp = fopen($filename, 'w');
    fputcsv($this->fp, array('Page Title', 'Nid', 'Region', 'Url'));
  }

  public function get_links($table_name, $field_name) {
    $query = $this->query_results($table_name, $field_name);


    while ($result = $query->fetch_object()) {
      if (!empty($result->url)) {

        if ($this->validate_url($result->url)) {
          $row = array($result->title, $result->nid, $result->region, $result->url);
          fputcsv($this->fp, $row);
        }

      }
    }

  }

  private function query_results($table_name, $field_name) {
    return $this->mysql->query("
      SELECT 
        bn.nid AS component_node,
        l.$field_name AS url,
        n.title AS title,
        n.nid AS nid,
        bn.region AS region
      FROM 
        main_baffin b
      JOIN 
        main_node n 
      ON
        b.nid = n.nid
      JOIN
        main_baffin_nodes bn
      ON
        bn.bid = b.bid
      JOIN
        $table_name l
      ON
        bn.nid = l.nid
      JOIN
        node nd
      ON nd.vid = l.vid
      WHERE
        nd.status = 1
      ORDER BY nid
    ");
  }

  private function validate_url($url) {
    return !strstr($url, 'search/') 
      && !strstr($url, 'd/') 
      && !strstr($url, 'c/') 
      && !strstr($url, 'http://')
      && !strstr($url, 'https://')
      && !intval($url);
  }

  private function close_session() {
    fclose($this->fp);
  }
}


$link_deal = new LinkDeal('localhost', 'root', '19GdB*82', 'drupal_zach', 'zfc_seo_urls.csv');
$link_deal->get_links('main_content_field_links', 'field_links_url');
$link_deal->get_links('main_content_field_link', 'field_link_url');

?>
