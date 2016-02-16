package iBook.utils;

import iBook.domain.Author;
import iBook.domain.Book;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class Test {

	public static void main(String[] args) 
	{
		    SessionFactory sf = Utils.getInstance().getSessionFactory();
	        Session session = sf.openSession();
	        session.beginTransaction();
	        
	        Query query = session.createSQLQuery("Select * from author").addEntity(Author.class);
			List<Author> authors = query.list();
			for( Author a : authors)
			{
				System.out.println("data ->" + a.getAuthorName());
			}
	        Utils.getInstance().commitTransaction(session);

	        
	}

}
