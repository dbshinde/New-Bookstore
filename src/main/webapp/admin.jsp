<jsp:useBean id="loginPage" class="iBook.web.LoginPage" />
<%@ page import="iBook.domain.Book"%>
<%@ page import="iBook.web.BookPage"%>
<%@ page import="iBook.web.BuyPage"%>
<%@ page import="java.util.List"%>
<%@ page import="iBook.domain.Authors2Books" %>
<%@ page import="java.util.Set" %>

<%
	loginPage.init(request, response, session);
	if (loginPage.isFormSubmitted()) {
		loginPage.submit();
	}
%>
	<jsp:include page="templates/adminHeader.jsp" />

	<div id="templatemo_content">
		<div class="cleaner_with_height">&nbsp;</div>
		<a href="subpage.jsp"><img src="images/templatemo_ads.jpg" alt="ads" style="padding-top: 10px;"/></a>
	<!-- end of content right -->

	<div class="cleaner_with_height">&nbsp;</div>
</div>
<!-- end of content -->
<jsp:include page="templates/footer.jsp" />