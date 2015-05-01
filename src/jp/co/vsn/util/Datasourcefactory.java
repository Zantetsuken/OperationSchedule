package jp.co.vsn.util;

import java.util.HashMap;
import java.util.Map;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Datasourcefactory {
	private static Datasourcefactory dsf;
	private static Map<String, DataSource> entry;
	private static InitialContext context;

	private Datasourcefactory() throws NamingException {
		entry = new HashMap<String, DataSource>();
		context = new InitialContext();
	}
	public static DataSource lookup(String jndiname) throws NamingException{
		if(dsf == null){
			dsf = new Datasourcefactory();
		}

		DataSource ds = (DataSource)entry.get(jndiname);
		if(ds == null){
			ds = (DataSource)((InitialContext) context).lookup(jndiname);
			entry.put(jndiname, ds);
		}

		return ds;

	}
}
