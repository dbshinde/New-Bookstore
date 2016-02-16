package iBook.dao.impl.hibernate;

import iBook.dao.BookDao;
import iBook.domain.Author;
import iBook.domain.Book;
import iBook.domain.Category;
import iBook.utils.Utils;
import iBook.web.SearchPage;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Restrictions;

/**
 * Book Dao Hibernate Implementation..
 */
public class BookDaoImpl implements BookDao {
	public static final int COVER_BOOK_COUNT = 4;


	@Override
	public void save(Book book) {
        Session session = Utils.getInstance().openTransaction();

        session.saveOrUpdate(book);

        Utils.getInstance().commitTransaction(session);
	}

	@Override
	public void update(Book book) {
        Session session = Utils.getInstance().openTransaction();

        session.merge(book);

        Utils.getInstance().commitTransaction(session);
	} 
    @Override
	public Book getBookById(int id) {
        Session session = Utils.getInstance().openTransaction();
        Object book = session.get(Book.class, id);

        Utils.getInstance().commitTransaction(session);

        return (book != null ? (Book) book : null);
	}

    public Author getAuthorById(int id) {
        Session session = Utils.getInstance().openTransaction();
        Object author = session.get(Author.class, id);

        Utils.getInstance().commitTransaction(session);

        return (author != null ? (Author) author : null);
	}
    
    @Override
	public List<Book> getBooksByAuthorId(Author author) {
        Session session = Utils.getInstance().openTransaction();

		Query query = session.getNamedQuery("listByAuthor");
		query.setParameter("author", author);

		List<Book> books = query.list();

        Utils.getInstance().commitTransaction(session);

        return books;
	}

    @Override
	public List<Book> getBooksByCategory(Category category) {
        Session session = Utils.getInstance().openTransaction();

        Query query = session.getNamedQuery("listByCategory");
		query.setParameter("category", category);

		List<Book> books = query.list();

        Utils.getInstance().commitTransaction(session);

        return books;
	}

    @Override
	public List<Book> getAllBooks() {
		return getBooksByQuery("listAllBook", 0);
	}

    @Override
	public List<Book> getBestSellers() {
		return getBooksByQuery("listBestSellers", 0);
	}

    @Override
	public List<Book> getCoverBooks() {
		return getBooksByQuery("listRandomBooks", COVER_BOOK_COUNT);
	}

    @Override
	public List<Book> getBooksByCriterias(Map<String, Object> criteria) {
        Session session = Utils.getInstance().openTransaction();
        Criteria criteriaObj = session.createCriteria(Book.class);
        if( criteria.containsKey(SearchPage.PARAM_CATEGORY) &&  criteria.get(SearchPage.PARAM_CATEGORY) != null &&  criteria.get(SearchPage.PARAM_CATEGORY) != "")
        {
        	Integer[] arr = {Integer.parseInt(((String) criteria.get(SearchPage.PARAM_CATEGORY)).split(",")[0])};
        	criteriaObj.add(Restrictions.conjunction().add(Restrictions.in("category.id", arr)));
        	criteria.remove(SearchPage.PARAM_CATEGORY);
        }
        
        if( criteria.containsKey(SearchPage.PARAM_TITLE) &&  criteria.get(SearchPage.PARAM_TITLE) != null &&  criteria.get(SearchPage.PARAM_TITLE) != "")
        {
        	criteriaObj.add(Restrictions.ilike(SearchPage.PARAM_TITLE, "%"+ criteria.get(SearchPage.PARAM_TITLE) +"%"));
        }
        if( criteria.containsKey(SearchPage.PARAM_BESTSELLER) &&  criteria.get(SearchPage.PARAM_BESTSELLER) != null &&  criteria.get(SearchPage.PARAM_BESTSELLER) != "")
        {
        	criteriaObj.add(Restrictions.eq(SearchPage.PARAM_BESTSELLER, criteria.get(SearchPage.PARAM_BESTSELLER)));
        }
        
        List<Book> resultList = criteriaObj.setCacheable(true).list();
        Utils.getInstance().commitTransaction(session);

        return (List<Book>) resultList;
	}
	
	private List<Book> getBooksByQuery(final String namedQueryName, final int limit) {
        Session session = Utils.getInstance().openTransaction();

		Query query = session.getNamedQuery(namedQueryName);
		if(limit > 0) {
			query.setMaxResults(limit);
		}

		List<Book> books = query.list();

        Utils.getInstance().commitTransaction(session);

        return books;
	}
	
	public List<Book> searchBooks( String title) {
		
		Session session = Utils.getInstance().openTransaction();
		Criteria cr = session.createCriteria(Book.class);
		/*Criterion price = Restrictions.gt("price", 200);
		Criterion authoro = Restrictions.ilike("author", "%"+author+"%");
		LogicalExpression andExp = Restrictions.and(price, authoro);
		cr.add( andExp );*/
		LogicalExpression orExp = Restrictions.or(Restrictions.ilike("title", "%"+title+"%"), Restrictions.ilike("title", "%"+title+"%"));
		cr.add( orExp );
		//cr.add(Restrictions.ilike("author", "%"+author+"%"));
		return cr.list();
		/*return sessionFactory.getCurrentSession()
			.createQuery("from Book b where b.author LIKE :author").setParameter("author", "%"+author+"%").list();*/
	}

}
