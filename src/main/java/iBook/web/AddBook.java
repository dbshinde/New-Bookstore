package iBook.web;

import iBook.dao.CategoryDao;
import iBook.dao.factory.DaoFactory;
import iBook.domain.Author;
import iBook.domain.Authors2Books;
import iBook.domain.Book;
import iBook.domain.Category;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Bean respoonsible for Book add.
 */
public class AddBook extends Form {
    /**
     * Parameter specifying title.
     */
    public static final String PARAM_TITLE = "title";
    /**
     * Parameter specifying author.
     */
    public static final String PARAM_AUTHOR = "author";
    /**
     * Parameter specifying category.
     */
    public static final String PARAM_CATEGORY = "category";
    /**
     * Parameter specifying bestsellers.
     */
    public static final String PARAM_BESTSELLER = "bestSeller";
    
    
    public static final String PARAM_PUBLISH_DATE = "publishDate";
    
    
    public static final String PARAM_PRICE = "price";
    
    
    public static final String PARAM_PAGES = "pages";
    
    
    public static final String PARAM_DESCRIPTION = "description";
    /**
     * Parameter specifying that no category is selected.
     */
    public static final String NO_CATEGORY = "no_cat";

    public static final String ERROR_MSGS = "errorMsgs";
    
    public static final String PARAM_BOOK_ID = "id";
    
    public static final String PARAM_AUTHOR_ID = "authorId";
    
    public static final String EDIT_BOOK = "editBook";
    
    private List<Book> searchedBookList = null;
    

    @Override
    public void submit() throws Exception 
    {
    	String title = getParameter(PARAM_TITLE);
    	String author = getParameter(PARAM_AUTHOR);
    	Integer category = getIntParameter(PARAM_CATEGORY);
    	String bestSeller = getParameter(PARAM_BESTSELLER);
    	Integer publishDate = getIntParameter(PARAM_PUBLISH_DATE);
    	Integer pages = getIntParameter(PARAM_PAGES);
    	String price = getParameter(PARAM_PRICE);
    	String description = getParameter(PARAM_DESCRIPTION);
    	boolean editBook = Boolean.parseBoolean(getParameter(EDIT_BOOK));
    	Integer bookId = getIntParameter(PARAM_BOOK_ID);
    	Integer authorId = getIntParameter(PARAM_AUTHOR_ID);
    	List<String> errorMsgs = validateForm();
    	
    	if( editBook )
		{
    		if(errorMsgs.isEmpty())
        	{
        		Book book = DaoFactory.getInstance().getBookDao().getBookById(bookId);
        		Author authorObj = DaoFactory.getInstance().getBookDao().getAuthorById(authorId);
        		if( authorObj == null || !authorObj.getAuthorName().equals(author))
        		{
        			authorObj = new Author(author);
        		}

        		book.setBestSeller(Boolean.parseBoolean(bestSeller));
        		book.setCategory(DaoFactory.getInstance().getCategoryDao().getCategoryById(category));
        		book.setDescription(description);
        		book.setPages(pages);
        		book.setPrice(Double.parseDouble(price));
        		book.setPublishDate(publishDate);
        		book.setTitle(title);
        		//book.setAuthor(authorObj);
        		DaoFactory.getInstance().getBookDao().update(book);
        		response.sendRedirect(ADMIN_DASHBOARD_URL);
        	}
        	else 
        	{
        		request.setAttribute(ERROR_MSGS, errorMsgs);
    			request.getRequestDispatcher(EDIT_BOOK_URL).forward(request, response);
        	}
		}
		else
		{
			if(errorMsgs.isEmpty())
	    	{
	    		Book book = new Book();
	    		Author authorObj = new Author(author);
	    		
	    		book.setBestSeller(Boolean.parseBoolean(bestSeller));
	    		book.setCategory(DaoFactory.getInstance().getCategoryDao().getCategoryById(category));
	    		book.setDescription(description);
	    		book.setPages(pages);
	    		book.setPrice(Double.parseDouble(price));
	    		book.setPublishDate(publishDate);
	    		book.setTitle(title);
	    		book.setPhotoUrl(getImagePath());
	    		Set s = new HashSet<Authors2Books>();
	    		s.add( new Authors2Books(authorObj, book));
	    		book.setAuthor(s);
	    		DaoFactory.getInstance().getBookDao().save(book);
	    		response.sendRedirect(ADMIN_DASHBOARD_URL);
	    	}
	    	else {
	    		//response.sendRedirect(response.encodeRedirectURL(ADD_BOOK_URL));
	    		request.setAttribute(ERROR_MSGS, errorMsgs);
				request.getRequestDispatcher(ADD_BOOK_URL).forward(request, response);
	    		//request.getRequestDispatcher(ADD_BOOK_URL).forward(request, response);
	    	}
		}
    }

    /**
     * Returns all categories.
     * @return      all categories list.
     */
    public List<Category> getCategories() {
        List<Category> categories = null;
        CategoryDao category = DaoFactory.getInstance().getCategoryDao();
        if(category != null) {
            categories = category.getAllCategories();
        }

        return categories;
    }

    public List<String> validateForm() 
    {
    	List<String> errorMsgs = new ArrayList<String>();
    	Map<String , Object> requestData = getParameters();
    	for( String key: requestData.keySet())
    	{
    		String[] valueArr = (String[]) requestData.get(key);
    		String value = valueArr[0];
    		if( value == null || "".equals(value))
    		{
    			errorMsgs.add("The "+ key +" should not be empty!");
    		}
    		if( PARAM_CATEGORY.equals(key) && (value == null || NO_CATEGORY.equals(value)))
    		{
    			errorMsgs.add("Please select category");
    		}
    	}
		return errorMsgs;
    }
    
    private String getImagePath()
    {
    	try
    	{
    		String ImageFile="";
    		String itemName = "";
    		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    		if (!isMultipart)
    		{
    			
    		}
    		else
    		{
    			FileItemFactory factory = new DiskFileItemFactory();
    			ServletFileUpload upload = new ServletFileUpload(factory);
    			List items = null;
    			try
    			{
    				items = upload.parseRequest(request);
    			}
    			catch (FileUploadException e)
    			{
    				e.getMessage();
    			}

    			Iterator itr = items.iterator();
    			while (itr.hasNext())
    			{
    				FileItem item = (FileItem) itr.next();
    				if (item.isFormField())
    				{
    					String name = item.getFieldName();
    					String value = item.getString();
    					if(name.equals("ImageFile"))
    					{
    						ImageFile=value;
    					}

    				}
    				else
    				{
    					try
    					{
    						itemName = item.getName();
    						String relativeWebPath = "books/" + itemName;
    						File savedFile = new File(request.getSession().getServletContext().getRealPath(relativeWebPath));
    						item.write(savedFile);
    						return itemName;
    					}
    					catch (Exception e)
    					{
    						
    					}
    				}
    			}
    		}
    	}
    	catch (Exception e)
    	{
    		
    	}
		return null;
    }
}
