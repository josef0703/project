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
- MultipartResolver Bean이 설정해야함.
- 상위 패키지에 Mvc설정 클래스 CommonsMultipartResolver 빈을 추가
- 공통 파일 처리용 클래스 생성
- 상위 패키지에 FileUtils 클래스 생성
    <pre>
    @Component
public class FileUtils {

	/** 오늘 날짜 */
	private final String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));

	/** 업로드 경로 */
	private final String uploadPath = Paths.get("C:", "develop", "upload", today).toString();

	/**
	 * 서버에 생성할 파일명을 처리할 랜덤 문자열 반환
	 * @return 랜덤 문자열
	 */
	private final String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	/**
	 * 서버에 첨부 파일을 생성하고, 업로드 파일 목록 반환
	 * @param files    - 파일 Array
	 * @param boardIdx - 게시글 번호
	 * @return 업로드 파일 목록
	 */
	public List<AttachDTO> uploadFiles(MultipartFile[] files, Long boardIdx) {

		/* 파일이 비어있으면 비어있는 리스트 반환 */
		if (files[0].getSize() < 1) {
			return Collections.emptyList();
		}

		/* 업로드 파일 정보를 담을 비어있는 리스트 */
		List<AttachDTO> attachList = new ArrayList<>();

		/* uploadPath에 해당하는 디렉터리가 존재하지 않으면, 부모 디렉터리를 포함한 모든 디렉터리를 생성 */
		File dir = new File(uploadPath);
		if (dir.exists() == false) {
			dir.mkdirs();
		}

		/* 파일 개수만큼 forEach 실행 */
		for (MultipartFile file : files) {
			try {
				/* 파일 확장자 */
				final String extension = FilenameUtils.getExtension(file.getOriginalFilename());
				/* 서버에 저장할 파일명 (랜덤 문자열 + 확장자) */
				final String saveName = getRandomString() + "." + extension;

				/* 업로드 경로에 saveName과 동일한 이름을 가진 파일 생성 */
				File target = new File(uploadPath, saveName);
				file.transferTo(target);

				/* 파일 정보 저장 */
				AttachDTO attach = new AttachDTO();
				attach.setBoardIdx(boardIdx);
				attach.setOriginalName(file.getOriginalFilename());
				attach.setSaveName(saveName);
				attach.setSize(file.getSize());

				/* 파일 정보 추가 */
				attachList.add(attach);

			} catch (IOException e) {
				throw new AttachFileException("[" + file.getOriginalFilename() + "] failed to save file...");

			} catch (Exception e) {
				throw new AttachFileException("[" + file.getOriginalFilename() + "] failed to save file...");
			}
		} // end of for

		return attachList;
	}

}
    </pre>
    -  uploadPath
        - "C;\develop\upload\업로드날짜"같은 패턴의 디렉터리 생성
    - ![image](https://user-images.githubusercontent.com/59104703/169696211-439f68c9-7295-45c9-b051-59edb66be793.png)
    **45~47라인**
        - if문에 파일이 담겨있는지 확인, 파일이 없으면 비어있는 리스트 반환
    **50번 라인**
        - tb_attach 테이블에 저장할 업로드 파일 정보를 담을 비어있는 리스트 생성
    **53~56번 라인**
        - dir 객체 변수에 업로드 경로 정보 저장
        - if문에서 uploadPath에 해당하는 디렉터리가 존재하지 않는 경우, 모든 디렉토리 생성

