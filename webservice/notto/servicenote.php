<?php 
include 'connection.php';
include 'util.php';
$var=$_SERVER['REQUEST_METHOD'];
if($var=='POST'){
    $title=$_POST['title'];
    $notes=$_POST['notes'];
   
    
    if(!isset($_POST['id'])){
        $email=$_POST['email'];
         $q="INSERT INTO `notes` (`id`, `title`, `notes`, `email`) VALUES (NULL, '$title', '$notes', '$email')";
        if($connect->query($q)){
            echo json_encode(createResponse(1,'catatan disimpan',""));
        }else{
            echo json_encode(createResponse(0,'catatan gagal disimpan',""));
        }
    }else{
        $id=$_POST['id'];
        $q="UPDATE `notes` SET `title`='$title',`notes`='$notes' WHERE `id`=$id";
        if($connect->query($q)){
            echo json_encode(createResponse(1,'perubahan catatan disimpan',""));
        }else{
            echo json_encode(createResponse(0,'perubahan catatan gagal disimpan',""));
        }
    }
    
}elseif($var=="DELETE"){
    
    if(isset(getallheaders()['id'])){
    $id= getallheaders()['id'];
    $q="DELETE FROM `notes` WHERE `id`=$id";
    if($connect->query($q)){
        echo json_encode(createResponse(1,'catatan dihapus',""));
    }else{
        echo json_encode(createResponse(0,'catatan gagal dihapus',""));
    }}
    
}elseif($var=='GET'){
    $res=Array();
    $res['notes']=Array();
 if(isset($_GET['email'])){
        $email=$_GET['email'];
        $q="SELECT * FROM `notes` WHERE email='$email'";
        if($result=$connect->query($q)){
            $res['result']=1;
            while($data=$result->fetch_assoc()){
                array_push($res['notes'],$data);
            }
            echo json_encode($res);
        }else{
            $res['result']=0;
            echo json_encode($res);;
        }
    }
}
?>