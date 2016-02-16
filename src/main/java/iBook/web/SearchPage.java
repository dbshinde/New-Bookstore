package iBook.web;

import iBook.dao.CategoryDao;
import iBook.dao.factory.DaoFactory;
import iBook.domain.Book;
import iBook.domain.Category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Bean respoonsible for Book Search.
 */
public class SearchPage extends Form {
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
    /**
     * Parameter specifying that no category is selected.
     */
    public static final String NO_CATEGORY = "no_cat";
    
    
    public static final String SEARCH_RESULT_PAGE = "searchListBooks.jsp";

    private List<Book> searchedBookList = null;

    @Override
    public void submit() throws Exception {
        String title = getParameter(PARAM_TITLE);
        String author = getParameter(PARAM_AUTHOR);
        String category = getParameter(PARAM_CATEGORY);
        Boolean bestSeller = Boolean.parseBoolean(getParameter(PARAM_BESTSELLER));
        if((category != null && !category.equals(NO_CATEGORY) && !category.equals("")) && (title != null && !title.isEmpty() || author!= null && !author.isEmpty())) 
        {
        	Map<String, Object> criteria  = new HashMap<String, Object>();
        	criteria.put(PARAM_TITLE, title);
        	criteria.put(PARAM_CATEGORY, category);
        	criteria.put(PARAM_BESTSELLER, bestSeller);
        	criteria.put(PARAM_AUTHOR, author);
        	searchedBookList = DaoFactory.getInstance().getBookDao().getBooksByCriterias(criteria);
        	session.setAttribute("data", searchedBookList);
            
        } else {
        	searchedBookList = DaoFactory.getInstance().getBookDao().getAllBooks();
            session.setAttribute("data", searchedBookList);
        }

        if( searchedBookList != null){
			response.sendRedirect(SEARCH_RESULT_PAGE);
			return;
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

}
