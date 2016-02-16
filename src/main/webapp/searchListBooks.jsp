<jsp:useBean id="searchPage" class="iBook.web.SearchPage" />
<%@ page import="iBook.domain.Book"%>
<%@ page import="iBook.web.BookPage"%>
<%@ page import="iBook.web.BuyPage"%>
<%@ page import="java.util.List"%>
<%@ page import="iBook.domain.Author" %>
<%@ page import="iBook.domain.Authors2Books" %>
<%@ page import="java.util.Set" %>
<%@ page import="iBook.domain.User"%>
<%@ page import="iBook.web.LoginPage"%>

<%
searchPage.init(request, response, session);
%>
<%
     User loggedInUser = (User) session.getAttribute(LoginPage.LOGGED_IN_USER);
     if (loggedInUser != null && loggedInUser.getIsAdmin() =='T') 
     {
	 	%>
	 		<jsp:include page="templates/adminHeader.jsp" />
	  	<%
 	 } 
     else 
     {
	    %>
	    	<jsp:include page="templates/header.jsp" />
	    <%
     }
%>

<div id="templatemo_content">

	<jsp:include page="templates/l_menu.jsp" />

	<div id="templatemo_content_right">
		<%
			List<Book> data = (List<Book>)session.getAttribute("data");
		if(data != null && !data.isEmpty()){
			for (int i = 1; i <= data.size(); i++) {
				Book book = data.get(i - 1);
				Authors2Books authors2Book = book.getAuthor().iterator().next();
				Author  author = authors2Book.getAuthor();
                StringBuffer authors = new StringBuffer();
                authors.append(author.getAuthorName());
		%>
		<div class="templatemo_product_box">
			<h1><%=((book.getTitle() != null && book.getTitle().length() > 15) ? book
						.getTitle().substring(0, 15) : book.getTitle())%>...
				<span>(by <%=authors.toString()%>)
				</span>
			</h1>
			<img src="images/books/<%=book.getPhotoUrl()%>"
				alt="<%=book.getTitle()%>" width="100px" height="150px" />
			<div class="product_info">
				<p><%=book.getDescription() != null
						&& book.getDescription().length() > 50 ? book
						.getDescription().substring(0, 50) : book
						.getDescription()%>
					...
				</p>
				<h3>
					$<%=book.getPrice()%></h3>
					<%
						if (loggedInUser != null && loggedInUser.getIsAdmin() =='T')
					    {
						 	%>
						        <div class="edit_button">
									<a href="editBook.jsp?<%= BookPage.PARAM_BOOK_ID%>=<%=book.getId()%>">Edit</a>
								</div>
			        		<%
					 	} 
						else 
						{
					        %>
					        <div class="buy_now_button">
									<a href="buy.jsp?<%= BuyPage.PARAM_BOOK_ID %>=<%=book.getId()%>">Add to Card</a>
							</div>
					        <%
					    }
					%>
				<div class="detail_button">
					<a href="book.jsp?id=<%=book.getId()%>">Detail</a>
				</div>
			</div>
			<div class="cleaner">&nbsp;</div>
		</div>
		<%
			if (i != 0 && i % 2 == 0) {
		%>
		<div class="cleaner_with_height">&nbsp;</div>
		<%
			} else {
		%>
		<div class="cleaner_with_width">&nbsp;</div>
		<%
			}
			}
		} else {
			%>
			
			<div style="height: 210px;"><h1>Sorry, no books are found in specified criteria!</h1></div>
			
			<%
		}
		%>
		<a href="subpage.jsp" style="padding-top: 15px;"><img src="images/templatemo_ads.jpg"
			alt="ads" /></a>
	</div>
	<!-- end of content right -->

	<div class="cleaner_with_height">&nbsp;</div>
</div>
<!-- end of content -->
<jsp:include page="templates/footer.jsp" />