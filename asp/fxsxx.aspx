<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div class="box">

<div class="topx"><img src="images/topx_02.jpg" /></div>
<div class="gyzy0">
<div class="gyzy">�𾴵�XX����/Ůʿ������</div>

<div class="fxsxx">
<span class="fxsxx1">��˾�ķ�����Ϣ����</span>
<div class="zjgxs"> <select name="" class="fug"><option></option></select> <span class="zjgxs1"><a href="#">�����µĹ�����</a></span></div>
<div class="fxsxx2">
 <dl>
    <dd>��˾���ƣ�</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��˾��ַ��</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��˾�绰��</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��˾��ҳ��</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��˾���棺</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
    <dd>��������</dd>
    <dt><div class="fxs1"><select name="" class="fu1"><option>����</option></select>  <select name="" class="fu2"><option>����</option></select>ʡ���У�
    <select name="" class="fu3"><option>ʯ��ׯ</option></select> ����<select name="" class="fu4"><option>����</option></select> �����أ� </div></dt>
     <dd>����Ʒ�ƣ�</dd>
    <dt><span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��1</span> 
        <span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��2</span>
        <span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��3</span> </dt>
     <dd>��˾��飺</dd>
    <dt><textarea name="" cols="" rows="" class="fgsjj"></textarea></dt>
     <dd>��˾ͼƬ��</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
     <dd>��ϵ��������</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��ϵ�˵绰��</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��ϵ��ְ��</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
    
 </dl>
<span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" /></a></span></div>
</div>


</div>


<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->


</div>


<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
<script type="text/javascript">
var speed=9//�ٶ���ֵԽ���ٶ�Խ��
var demo=document.getElementById("demo");
var demo2=document.getElementById("demo2");
var demo1=document.getElementById("demo1");
demo2.innerHTML=demo1.innerHTML
function Marquee(){
if(demo2.offsetWidth-demo.scrollLeft<=0)
demo.scrollLeft-=demo1.offsetWidth
else{
demo.scrollLeft++
}
}
var MyMar=setInterval(Marquee,speed)
demo.onmouseover=function() {clearInterval(MyMar)}
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
</script>
<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
</body>
</html>
