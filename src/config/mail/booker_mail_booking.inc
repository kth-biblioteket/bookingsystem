<?php
global $mrbslang, $environment, $url_base;
$css = '';
$css_file = 'css/mrbs-mail.css';
if (file_exists($css_file))
{
    $fh = fopen($css_file, 'r');
    $css = fread($fh, filesize($css_file));
}
$html_body['content'] = '
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title></title>
  <style type="text/css">'
      . $css .
  '</style>
</head>
<body id="mrbs">
  <!--[if mso]>
      <style type="text/css">
          body, table, td, h1, div {font-family: Arial, Helvetica, sans-serif !important;}
      </style>
  <![endif]-->';

if ($mrbslang == 'sv') {
  setlocale(LC_ALL,"sv_SE.UTF-8");
}
else {
  setlocale(LC_ALL,"en_GB.UTF-8");
}

if(stripos(get_campus($data['campus'], $mrbslang), 'zoom')==false) {
  $html_body['content'] .= get_vocab("mail_text");
} else {
  $html_body['content'] .= get_vocab("mail_text_digital");
}


$html_body['content'] = str_replace("@@room_number",$data['room_number'],$html_body['content']);

if ($data['campus'] > 0) {
  $html_body['content'] = str_replace("@@place",get_campus($data['campus'], $mrbslang),$html_body['content']);
} else {
  $html_body['content'] = str_replace("@@place",$data['room_name'],$html_body['content']);
}
$html_body['content'] = str_replace("@@timedate",date("H:i",$data['start_time']) . ', ' . strftime("%A %d %B",$data['start_time']),$html_body['content']);
//dont use $_SERVER['HTTP_HOST' for KIOSK
if(stripos($_SERVER['PHP_SELF'], 'kiosk')==false) {
  $phpself = $_SERVER['PHP_SELF'];
} else {
  if(stripos($_SERVER['PHP_SELF'], 'readingstudio')==false) {
    $phpself = '/mrbsgrupprum/x.php';
  } else {
    $phpself = '/mrbsreadingstudio/x.php';
  }
}
$linktobooking = '<table border="0" cellspacing="0" cellpadding="0">
  <tbody>
    <tr>
      <td align="center" style="border-radius: 30px;" bgcolor="#B0C92B">
        <a style="padding: 15px 25px; border-radius: 30px; border: 1px solid #B0C92B; border-image: none; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 16px; font-weight: bold;text-decoration: none; display: inline-block;" href="' . $url_base . '/edit_entry.php?id=' . $data["id"] . '&lang=' . $mrbslang . '">' . get_vocab("mail_link_text") . '</a>
      </td>
    </tr>
  </tbody>
</table>';
$html_body['content'] = str_replace("@@linktobooking", $linktobooking, $html_body['content']);
if($data['area_map']) {
  $html_body['content'] = str_replace("@@map",'<br><br><img src="' . $url_base . '/' . 'images' .'/' . $data['area_map_image'] .'"></img>', $html_body['content']);
}
$html_body['content'] .= '
</body>
</html>';