<jsp:useBean id="addBook" class="iBook.web.AddBook" />
<jsp:useBean id="bookPage" class="iBook.web.BookPage" />
<%@ page import="iBook.utils.Utils" %>
<%@ page import="iBook.web.BookPage" %>
<%@ page import="iBook.domain.Book"%>
<%@ page import="iBook.web.AddBook"%>
<%@ page import="java.util.*"%>
<%@ page import="iBook.domain.*"%>
<%
	addBook.init(request, response, session);
	Book currentBook = Utils.getInstance().getBookById(addBook.getIntParameter(BookPage.PARAM_BOOK_ID));
	if (addBook.isFormSubmitted()) {
		try {
			addBook.submit();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
%>
<jsp:include page="templates/adminHeader.jsp" />

<div id="templatemo_content">

	<jsp:include page="templates/l_menu.jsp" />

	<div id="templatemo_content_right">
		<h1>Edit Book</h1>
		<%
			if (request.getAttribute(AddBook.ERROR_MSGS) != null) {
				List<String> errorMsgs = (List<String>) request
						.getAttribute(AddBook.ERROR_MSGS);
				if (!errorMsgs.isEmpty()) {
		%>
		<h2>
			<%
				for (String error : errorMsgs) {
			%>
			<p><font color="red"><%=error%></font></p>
			<%
				}
			%>
		</h2>
		<%
			}
			}
		%>
		<form method="POST" name="addBook">
			<p>
				<label for="<%=AddBook.PARAM_TITLE%>">Title:</label> 
				<input type="text" name="<%=AddBook.PARAM_TITLE%>"
					   align="middle" value="<%=currentBook.getTitle() != null ? currentBook.getTitle(): ""%>" 
					   style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_AUTHOR%>">Author:</label> 
				<input type="text" name="<%=AddBook.PARAM_AUTHOR%>" value="<%=currentBook.getAuthor() != null ? currentBook.getAuthor().iterator().next().getAuthor().getAuthorName(): ""%>" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_DESCRIPTION%>">Description:</label> 
				<input type="text" name="<%=AddBook.PARAM_DESCRIPTION%>"
					   value="<%=currentBook.getDescription() != null ? currentBook.getDescription(): ""%>" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_PRICE%>">Price:</label> 
				<input type="text" name="<%=AddBook.PARAM_PRICE%>"
					   value="<%= currentBook.getPrice()%>" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_PAGES%>">Pages:</label> 
				<input type="text" name="<%=AddBook.PARAM_PAGES%>"
					   value="<%=currentBook.getPages()%>" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_PUBLISH_DATE%>">Publishing Year(yyyy):</label> 
				<input type="text" name="<%=AddBook.PARAM_PUBLISH_DATE%>"
					   value="<%=currentBook.getPublishDate()%>" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_CATEGORY%>">Category:</label> <select
					name="<%=AddBook.PARAM_CATEGORY%>"
					style="margin-left: 117px; margin-bottom: 20px;">
					<option value="<%= AddBook.NO_CATEGORY%>">Select Category</option>
					<%
						List<Category> categories = addBook.getCategories();
						for (Category category : categories) {
							if( category.getId() == currentBook.getCategory().getId())
							{
								%>
								<option selected value="<%=currentBook.getCategory().getId()%>"><%=currentBook.getCategory().getCategoryName()%></option>
								<%
							}
							else
							{
								%>
								<option value="<%= category.getId() %>"><%=category.getCategoryName()%></option>
								<%
							}
						}
					%>
				</select>
			</p>
			<p>
				<label for="<%=AddBook.PARAM_BESTSELLER%>">Bestseller: </label> <input
					type="checkbox" name="<%=AddBook.PARAM_BESTSELLER%>" value="<%=currentBook.isBestSeller()%>"
					style="margin-left: 114px; margin-bottom: 20px;" checked>
			</p>
			<input type="hidden" name="<%=AddBook.PARAM_IS_SUBMITTED%>"
				value="<%= addBook.getParameter(AddBook.PARAM_IS_SUBMITTED) == "true" ? "false" : "true"%>"/>
			<input type="hidden" name="<%=AddBook.EDIT_BOOK%>"
				value="true"/>
			<input type="hidden" name="<%=AddBook.PARAM_BOOK_ID%>"
				value="<%= currentBook.getId()%>"/>
			<input type="hidden" name="<%=AddBook.PARAM_AUTHOR_ID%>"
				value="<%= currentBook.getAuthor().iterator().next().getAuthor().getId()%>"/>
					
			<div class="buy_now_button" style="float: center; padding-left: 10px;">
				<a href="javascript: document.addBook.submit()">Edit Book</a>
			</div>
		
		</form>
	</div>
	<!-- end of content right -->

	<div class="cleaner_with_height">&nbsp;</div>
</div>

<jsp:include page="templates/footer.jsp" />