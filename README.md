# JBLOG

 ### 어노테이션(Annotation) 정리
 * * *
#### Bean Class
 @Component
  ```
  @Component("이름")으로 달아두면 xml의 빈으로 등록을 해달라는 표시
  보통 클래스 이름의 첫글자를 소문자로 둠
  ex) Example -> example
  
  (xml)
  <context:component-scan base-package="" />
  ```
 @Controller
  ```
  해당하는 클래스를 웹 요청을 처리하는 컨트롤러로 사용을 할 수 있음
  @RequestMapping을 통해 경로 설정
  + <bean id="클래스 이름" class="..package.클래스이름" />
  + <context:component-scan> 태그 이용
  ```
 @Service
  ```
  Repository를 통해 DB에서 데이터를 가져온 후 컨트롤러에게 전달해주는 클래스임을 나타냄
  ```
 @Repository
 @Autowired
  ```
  의존관계를 자동으로 설정할 때 사용하며 의존하는 객체를 타입에 맞춰 삽입을 해줌
  해당 타입의 빈 객체가 존재하지않거나 2개 이상 존재할 경우 예외 발생
  + 같은 타입의 빈이 2개 이상 존재하여 예외 발생 시
   @Qualifier("빈 이름") 을 사용하면 문제 해결
  ```
 @Qualifier
  ```
  @Autowired와 함께 사용 / @Qualifier("빈 이름")
  동일 타입의 빈 객체가 존재할 때 특정한 빈을 삽입할 수 있게 해줌
  <bean>
     <qualifier value="빈 이름" />
  ```
 @Named

#### 설정 파일
* @Configuration
* @Bean
* @Qulifier
