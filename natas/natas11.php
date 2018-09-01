<?php


$encrypted_cookie = base64_decode("ClVLIh4ASCsCBE8lAxMacFMZV2hdVVotEhhUJQNVAmhSEV4sFxFeaAw=");
$decrypted_cookie = json_encode(array( "showpassword"=>"no", "bgcolor"=>"#ffffff"));  
$key = '';
for($i=0;$i<strlen($decrypted_cookie);$i++) {  
    $key .= $encrypted_cookie[$i] ^ $decrypted_cookie[$i % strlen($decrypted_cookie)];  
}  

$custom_cookie = json_encode(array( "showpassword"=>"yes", "bgcolor"=>"#ffffff"));
$cc_out = '';
for($i=0;$i<strlen($custom_cookie);$i++) {  
    $cc_out .= $custom_cookie[$i] ^ $key[$i % strlen($custom_cookie)];  
}  

print(base64_encode($cc_out));

?>  
