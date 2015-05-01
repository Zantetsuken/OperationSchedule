package jp.co.vsn.dbaccess;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class DBAccess {
	private String driver;
	private String url;
	private String user;
	private String password;
	private Connection connection;
	private Statement statement;
	private ResultSet resultset;
	private PreparedStatement pStmt;
	/**
	 * コンストラクタ
	 * @param driver ドライバー
	 * @param url URL
	 * @param user ユーザー名
	 * @param password パスワード
	 */
	public DBAccess(String driver, String url, String user, String password) {
		this.driver = driver;
		this.url = url;
		this.user = user;
		this.password = password;
	}

	/**
	 * 引数なしのコンストラクタ
	 * 既定値を使用する
	 */
	public DBAccess() {
		driver = "com.mysql.jdbc.Driver";
		url = "jdbc:mysql://localhost/vsn_scheduledb";
		user = "root";
		password = "VSOLuser123";
	}
	/**
	 * データベースへの接続を行う1
	 */
	public synchronized void open() throws Exception {
		Class.forName(driver);
		connection = (Connection) DriverManager.getConnection(url, user, password);
		statement = (Statement) connection.createStatement();
	}

	/**
	 * データベースへの接続を行う2
	 */
	public PreparedStatement preopen(String sql) throws Exception {
		Class.forName(driver);
		connection = (Connection) DriverManager.getConnection(url, user, password);
		pStmt = connection.prepareStatement(sql);
		return pStmt;
	}


	/**
	 * SQL 文を実行した結果の ResultSet を返す
	 * @param sql SQL 文
	 */
	public ResultSet getResultSet(String sql) throws Exception  {
		if ( statement.execute(sql) )  {
			return statement.getResultSet();
		}
		return null;
	}
	/**
	 * SQL 文の実行(SELECT)
	 * @param sql SQL 文
	 */
	public void execute(String sql) throws Exception  {
		statement.execute(sql);
	}
	/**
	 * SQL 文の実行(DELETE、UPDATE)
	 * @param sql SQL 文
	 */
	public int executeUpdate(String sql) throws Exception  {
		return statement.executeUpdate(sql);
	}
	/**
	 * データベースへのコネクションのクローズ
	 */
	public synchronized void close() throws Exception {
		if ( resultset  != null ) resultset.close();
		if ( statement  != null ) statement.close();
		if ( connection != null ) connection.close();
	}
}
