<!--
	��ҳ
	�ļ�����index.aspx
	�����������
-->

<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Register Src="include/Top10manu.ascx" TagName="Top10manu" TagPrefix="uc2" %>
<%@ Register Src="include/top10product.ascx" TagName="top10product" TagPrefix="uc3" %>
<%@ Register Src="include/top10brand.ascx" TagName="top10brand" TagPrefix="uc4" %>
<%@ Register Src="include/clfx.ascx" TagName="clfx" TagPrefix="uc5" %>
<%@ Register Src="include/rxcp.ascx" TagName="rxcp" TagPrefix="uc6" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
    <title>�ڲ���-----������װ����ҵ�Ĺ�װ���Ͽ�͹�Ӧ����Ϣ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
</head>

<body style=" text-align:center">
    <!-- ͷ����ʼ-->
    <!-- #include file="static/header.aspx" -->
    <!-- ͷ������-->


    <!-- ������ʼ-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- ��������-->


    <!-- banner��ʼ-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner ����-->

    <div class="left">

        <!-- top10��Ʒ��ʼ-->
        <uc3:top10product ID="top10product" runat="server" />
        <!-- top 10��Ʒ ����-->

        <!-- top10���̿�ʼ-->
        <uc2:Top10manu ID="Top10manu" runat="server" />
        <!-- top 10��Ʒ ����-->
    </div>


    <div class="center">
        <!-- �²�Ʒ��ʼ-->
        <!-- #include file="static/newproducts.aspx" -->
        <!-- �²�Ʒ ����-->
        
        <!-- ���Ϸ��� ��ʼ-->
        <uc5:clfx ID="clfx" runat="server" />
        <!-- ���Ϸ��� ����-->

    </div>



    <div class="right">
        <!-- 10��Ʒ�� ��ʼ-->
        <uc4:top10brand ID="top10brand" runat="server" />
        <!-- 10��Ʒ�� ����-->

        <div class="right1">
            <!--  �Ҳ��� ��ʼ-->
            <!-- #include file="static/ads.aspx" -->
            <!-- �Ҳ��� ����-->
        </div>

    </div>


    <!--  ������Ʒ ��ʼ-->
    <uc6:rxcp ID="rxcp" runat="server" />
    <!-- ������Ʒ ����-->

    <!--  �������� ��ʼ-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- �������� ����-->


    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->


    </div>

    <!--  footer ��ʼ-->
    <script type="text/javascript"><!--//--><![CDATA[//><!--
    function menuFix() {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
              "");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
    <script type="text/javascript">
        var speed = 9//�ٶ���ֵԽ���ٶ�Խ��
        var demo = document.getElementById("demo");
        var demo2 = document.getElementById("demo2");
        var demo1 = document.getElementById("demo1");
        demo2.innerHTML = demo1.innerHTML
        function Marquee() {
            if (demo2.offsetWidth - demo.scrollLeft <= 0)
                demo.scrollLeft -= demo1.offsetWidth
            else {
                demo.scrollLeft++
            }
        }
        var MyMar = setInterval(Marquee, speed)
        demo.onmouseover = function () { clearInterval(MyMar) }
        demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }
    </script>
    <script type="text/javascript"><!--//--><![CDATA[//><!--
    function menuFix() {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
              "");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
    <!-- footer ����-->


</body>
</html>





