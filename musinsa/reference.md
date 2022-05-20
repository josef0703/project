# mysql 디비 연결 테스트
<pre>
private static final String Driver = "com.mysql.cj.jdbc.Driver";
    private static final String URL="jdbc:mysql://localhost:3306/mybatis_test?useSSL=false&serverTimezone=Asia/Seoul";
    private static final String User="root";
    private static final String pass="1234";

    @Test
    public void testConnection() throws Exception {
        Class.forName(Driver);
        try (Connection connection = DriverManager.getConnection(URL, User, pass)) {
            System.out.println("connection = " + connection);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    </pre>
