# CoreDataMVVM


## 순서
Core data 하는 순서가 

1. class CoreDataViewModel 를 생성하는데 ObservableObject 프로토콜을 준수하게 한다. 
그리고 안에 let container: NSPersistentContainer 를 준수하게 생성하고 그 아래 init(){} 내부에 container 를 할당한다. 
안에 NSPersistentContainer(name: "") 안에는 DataModel 파일 명을 넣는다. 

그리고 func fetchFruits() 함수는 그 저장소를 불러오는 함수이다. 여기서 savedEntites 라는 배열을 생성하는데 이때 @Published
로 생성해서 변경되는 값을 갖고오도록 한다. 

그 외에 add, delete, update 함수를 생성한다. 

2. 그리고 MVVM 아키텍처에 맞게 코드를 작성하자 
