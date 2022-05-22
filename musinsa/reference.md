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
    
spring.datasource.url=jdbc:mysql://localhost:3306/mybatis_test
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.username=root
spring.datasource.password=1234

# 인텔리제이,Mybatis, Gradle 설정
```Application.properties```
- batis.mapper-locations=classpath:mapper/**.xml
```Mapper```
- resources/mapper/*.xml로 위치 해놔야 Aplicaiton.properties에서 설정한 값이 들어감
- 안하면 BeanCreationException 에러 발생


# 타임리프
- url에 www.붙으면 mdoel값 안 넘어감<html lang="en" xmlns:th="http://thymeleaf.org"> 

# 파일 업로드
- Multipart 처리하기 위해 아차피에서 제공하는 ```commos-fileupload```,```commons-io``` 라이브러리 사용
- MultipartResolver Bean이 설저되어야 함
- 
