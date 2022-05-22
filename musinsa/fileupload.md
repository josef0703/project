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
    ![image](https://user-images.githubusercontent.com/59104703/169696355-d7ba3409-bec5-4321-966e-7b1104675f0b.png)
    **59~89번 라인**
          - 파일 생성, 파일 정보를 리스트에 저장하는 가장 핵심 로직
          - extension변수에 파일 확장자, saveName에 랜덤 문자열과 확장자 합친 파일명 저장
          - 67~68라인에는 target변수에 파일 정보에 해당하는 파일 생성
          - transferTo 메서드를 이용해서 target에 담긴 파일 정보에 해당하는 파일을 생성
          - 71~78라인에서는 AttachDTO 객체에 파일 정보를 담고, attachList에 파일 정보를 추가합니다. 이러한 작업의 반복이 마무리되면 파일 정보를 담은 attachList를 반환
