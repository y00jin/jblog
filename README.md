# JBLOG

 ### 어노테이션(Annotation) 정리
 * * *
#### Bean Class
 @Component
  @Component("이름")으로 달아두면 xml의 빈으로 등록을 해달라는 표시
  보통 클래스 이름의 첫글자를 소문자로 둠
  ex) Example -> example
  
  (xml)
  <context:component-scan base-package="" />
  
 @Controller
  해당하는 클래스를 웹 요청을 처리하는 컨트롤러로 사용을 할 수 있음
  + <bean id="클래스 이름" class="..package.클래스이름" />
  + <context:component-scan> 태그 이용
  
 @Service
 @Repository
 @Autowired
 @Named

#### 설정 파일
* @Configuration
* @Bean
* @Qulifier
