<?php
class Scan {

    public string $html;
    public string $cookie = 'cookie.txt';
    public string $referer = 'https://google.com';
    public string $user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0';
    public array $inputs = [];

    public function __construct(string $url)
    {
        $c = curl_init($url);
        curl_setopt($c, CURLOPT_COOKIEJAR, $this->cookie);
        curl_setopt($c, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($c, CURLOPT_REFERER, $this->referer);
        curl_setopt($c, CURLOPT_USERAGENT, $this->user_agent);
        $this->set_headers($c);
    }

    private function set_headers($curl)
    {
        $headers = [];
        curl_setopt($ch, CURLOPT_HEADERFUNCTION, 
            function($curl, $header) use (&$headers) {
                $len = strlen($header);
                $header = explode(':', $header, 2);

                # Ignore invalid headers
                if (count($header) < 2) return $len;
                $headers[strtolower(trim($header[0]))][] = trim($header[1]);
                return $len;
        });
        $this->headers = $headers;
    }

    private function set_dom(): void
    {
        $this->DOM = new DOMDocument();
        $this->DOM->loadHTML($this->html);
    }

    public function get_inputs(): void
    {
        $this->inputs = $this->DOM->getElementsByTagName('input');
        return $this->inputs;
    }

    public function execute(): void
    {
        $this->html = curl_exec($c);
        $this->set_dom();
    }
}
