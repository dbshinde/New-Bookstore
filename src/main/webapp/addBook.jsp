<jsp:useBean id="addBook" class="iBook.web.AddBook" />
<%@ page import="iBook.domain.Book"%>
<%@ page import="iBook.web.AddBook"%>
<%@ page import="java.util.*"%>
<%@ page import="iBook.domain.*"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
	addBook.init(request, response, session);
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
		<h1>Add new Book</h1>
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
		<form method="POST" name="addBook" enctype="multipart/form-data">
		
			<p>
				<label for="<%=AddBook.PARAM_TITLE%>">Title:</label> 
				<input type="text" name="<%=AddBook.PARAM_TITLE%>"
					   align="middle" value="" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_AUTHOR%>">Author:</label> 
				<input type="text" name="<%=AddBook.PARAM_AUTHOR%>"
					   value="" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_DESCRIPTION%>">Description:</label> 
				<input type="text" name="<%=AddBook.PARAM_DESCRIPTION%>"
					   value="" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_PRICE%>">Price:</label> 
				<input type="text" name="<%=AddBook.PARAM_PRICE%>"
					   value="" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_PAGES%>">Pages:</label> 
				<input type="text" name="<%=AddBook.PARAM_PAGES%>"
					   value="" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_PUBLISH_DATE%>">Publishing Year(yyyy):</label> 
				<input type="text" name="<%=AddBook.PARAM_PUBLISH_DATE%>"
					   value="" style="margin-left: 30px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="<%=AddBook.PARAM_CATEGORY%>">Category:</label> <select
					name="<%=AddBook.PARAM_CATEGORY%>"
					style="margin-left: 117px; margin-bottom: 20px;">
					<option value="<%= AddBook.NO_CATEGORY%>">Select Category</option>
					<%
						List<Category> categories = addBook.getCategories();
						for (Category category : categories) {
					%>
					<option value="<%=category.getId()%>"><%=category.getCategoryName()%></option>
					<%
						}
					%>
				</select>
			</p>
			<p>
				<label for="<%=AddBook.PARAM_BESTSELLER%>">Bestseller: </label> <input
					type="checkbox" name="<%=AddBook.PARAM_BESTSELLER%>" value="true"
					style="margin-left: 114px; margin-bottom: 20px;">
			</p>
			<p>
				<label for="photoUrl">Cover Image: </label>
				<input type="file" name="photoUrl" id="photoUrl" />
			</p>
			<input type="hidden" name="<%=AddBook.PARAM_IS_SUBMITTED%>"
				value="<%= addBook.getParameter(AddBook.PARAM_IS_SUBMITTED) == "true" ? "false" : "true"%>"
				/>
				
			<div class="buy_now_button" style="float: center; padding-left: 10px;">
				<a href="javascript: document.addBook.submit()">Add Book</a>
			</div>
		
		</form>
	</div>
	<!-- end of content right -->

	<div class="cleaner_with_height">&nbsp;</div>
</div>

<jsp:include page="templates/footer.jsp" />