<%@page import="uuu.etgt.entity.*"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>結帳成功</title>
		<%@include file="/subviews/global.jsp" %>
        <style>
        	 body{
        	background-image: url(https://media.giphy.com/media/tVFCT2uq9HL0M58KBd/giphy.gif);
			background-color:mintcream;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-size: cover;
		}
        	
            #cartTable {
			  font-family: Arial, Helvetica, sans-serif;clear:both;
			  border-collapse: collapse; width: 85%; margin: auto;box-shadow:gray 1px 1px 2px;font-size: 30px;
			}
			#cartTable th{border: 1px solid #ddd;background-color: #ffb366;color: white;font-size: smaller;padding:1ex}
			#cartTable td, #cartTable caption {border: 1px solid #ddd;padding: 8px;}
			#cartTable tr:nth-child(even){background-color: #f2f2f2;}
			#cartTable tr:hover {background-color: #efefef;}
			#cartTable caption {padding: 8px 3px;}			
			#cartTable>tbody>tr>td:last-child{text-align: right}
			#cartTable>tfoot>tr>td:last-child{text-align: right}	 
			.itemPhoto{width:5%;midth:48px;vertical-align: middle;}
		</style>
	</head>
	<body>
		<jsp:include page='/subviews/header.jsp'>			
			<jsp:param value="結帳成功" name="subHeader"/>			
		</jsp:include>
		<%@ include file='/subviews/nav.jsp' %>	
		<article>
			<%
				Order order = (Order)request.getAttribute("order");
				if(order!=null){
			%>
				<div>
				<div style='float:left;width:40%'>
					訂單編號: <%= order.getId() %>,訂購人: ${sessionScope.member.name}<br>
					訂購日期時間: <%= order.getOrderDate() %> <%= order.getOrderTime() %>,
					處理狀態: <%= order.getStatus() %><br>
					付款方式: <%= order.getPaymentType().getDesciption() %>, 手續費:<%= order.getPaymentFee() %><br>
					貨運方式: <%= order.getShippingType().getDesciption() %>元, 物流費:<%= order.getShippingFee() %><br>
					<div >
						<h1>含物流費總金額: <%= order.getTotalAmount() + order.getShippingFee() + order.getPaymentFee() %>元</h1>
					</div>
				</div>
				<fieldset style='float:left;width:40%;padding-left: 1em'>
					<legend>收件人</legend>姓名: <%= order.getRecipientName() %>, 
						Email: <%= order.getRecipientEmail() %>, 電話: <%= order.getRecipientPhone() %><br> 
					收件地址: <%= order.getShippingAddress() %>
				</fieldset>
			</div>
			<% if(order.getOrderItemSet()!=null && order.getOrderItemSet().size()>0){%>
			<table id='cartTable'>
				<caption>訂單明細</caption>
				<thead>
					<tr>
						<th>名稱</th><th>口味</th><th>重量</th>
						<th>售價</th><th>數量</th><th>小計</th>						
					</tr>
				</thead>									
			    <tbody>
			    	<% %>
					<% for(OrderItem item:order.getOrderItemSet()){
						Product p = item.getProduct();
						Flavor flavor = item.getFlavor();						
					%>
					<tr>							
						<td><img class='itemPhoto' src='<%= flavor!=null?flavor.getPhotoUrl():p.getPhotoUrl() %>'><!--圖片-->
								<%= p.getName() %></td><!-- 名稱 -->
						<td><%= flavor!=null?flavor.getFlavorName():"" %></td><!--口味-->
						<td><%= item.getWeight() %></td><!--重量-->
						<td><%= item.getPrice() %></td><!--售價-->
						<td><%= item.getQuantity() %></td><!--數量-->
						<td><%= item.getPrice() * item.getQuantity() %></td><!--小計:售價*數量 -->						
					</tr>
					<%}%>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" style='text-align: right'>共購買了 <%= order.getOrderItemSet().size() %>項, 
													<%= order.getTotalQuantity() %>件 商品</td>
						<td colspan="3" style='text-align: right'>總金額 <%= order.getTotalAmount() %> 元</td>
					</tr>
					<tr><td colspan='6' style='border-right: none'>
						<input type='button' value='回好茶清單' onclick='location.href="../products_list.jsp"'>												
						</td>	
					</tr>
				</tfoot>
			</table>
			<% } %>
			<% }%>
			
		</article>
		<%@ include file='/subviews/footer.jsp' %>
	</body>
</html>