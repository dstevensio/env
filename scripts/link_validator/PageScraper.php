<?php

include_once 'LinkValidator.php';

class PageScraper {
  private $file;
  private $pages;
  private $fp;

  public function __construct($file, $pages) {
    $this->file = $file;
    $this->pages = $pages;
    $this->init();
  }

  public function scrape_data() {
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
          fputcsv($this->fp, array($page, $link, $response['http_code'], $response['type']));
        }
      }
    }

    fclose($this->fp);
  }

  private function init() {
    $this->fp = fopen('footwear_scrape.csv', 'w');
    fputcsv($this->fp, array('Page', 'Link', 'Status Code', 'Type'));
  }
}

$pages = array(
  'Shoes' => 'http://www.zappos.com/shoes',
  'Boys Shoes' => ' http://www.zappos.com/boys-shoes',
  'Girls Shoes' => ' http://www.zappos.com/girls-shoes',
  'Men’s Shoes' => 'http://www.zappos.com/mens-shoes',
  'Women’s Shoes' => 'http://www.zappos.com/womens-shoes',
  'Bridal Shoes' => 'http://www.zappos.com/bridal-shoes',
  'Women’s Boots' => 'http://www.zappos.com/womens-boots',
  'Kids Shoes' => 'http://www.zappos.com/kids-shoes',
  'Sandals' => 'http://www.zappos.com/sandals',
  'Boots' => 'http://www.zappos.com/boots',
  'Heels' => 'http://www.zappos.com/heels',
  'Dress Shoes=> http://www.zappos.com/dress-shoes',
  'Men\'s Boots' => 'http://www.zappos.com/mens-boots',
  'Women\'s Sandals' => 'http://www.zappos.com/womens-sandals',
  'Men\'s Sandals' => 'http://www.zappos.com/mens-sandals',
  'Flip Flops' => 'http://www.zappos.com/flip-flops',
  'Oxfords' => 'http://www.zappos.com/oxfords',
  'Wedges' => 'http://www.zappos.com/wedges',
  'Flats' => 'http://www.zappos.com/flats',
  'Loafers' => 'http://www.zappos.com/loafers',
  'Sneakers' => 'http://www.zappos.com/sneakers',
  'Clogs & Mules' => 'http://www.zappos.com/clogs-mules',
  'Ankle Boots' => 'http://www.zappos.com/ankle-boots',
  'Athletic Shoes' => 'http://www.zappos.com/athletic-shoes',
  'Casual Shoes' => 'http://www.zappos.com/casual-shoes',
  'Slippers' => 'http://www.zappos.com/slippers',
  'Dress Flats' => 'http://www.zappos.com/dress-flats',
  'Dress Heels' => 'http://www.zappos.com/dress-heels',
  'Cleats' => 'http://www.zappos.com/cleats',
  'Baby Shoes' => 'http://www.zappos.com/baby-shoes',
  'Comfort Shoes' => 'http://www.zappos.com/comfort-shoes',
  'Men\'s' => ' http://www.zappos.com/mens',
  'Women\'s' => ' http://www.zappos.com/womens',
  'Kids' => 'http://www.zappos.com/kids',
  'Winter Boots' => 'http://www.zappos.com/winter-boots',
  'Snow Boots' => 'http://www.zappos.com/snow-boots',
  'Vegan' => 'http://www.zappos.com/vegan'
);

?>
