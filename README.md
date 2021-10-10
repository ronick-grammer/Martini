# Martini

<p align="center">
<img src="https://img.shields.io/badge/-000000?style=flat&logo=ios" alt="ios" maxWidth="100%">
<img src="https://img.shields.io/badge/UIkit-000000?style=flat&logo=UIkit" alt="uikit" maxWidth="100%">
<img src="https://img.shields.io/badge/Swift-000000?style=flat&logo=Swift" alt="swift" maxWidth="100%">
<img src="https://img.shields.io/badge/-Firebase-000000?style=flat&logo=Firebase" alt="firebase" maxWidth="100%">
<img src="https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github" alt="github" maxWidth="100%">
<img src="https://img.shields.io/badge/-Xcode-000000?style=flat-square&logo=Xcode" alt="Xcode" maxWidth="100%">
<img src="https://img.shields.io/badge/-Trello-000000?style=flat&logo=Trello" alt="trello" maxWidth="100%">
<img src="https://img.shields.io/badge/-Figma-000000?style=flat&logo=Figma" alt="figma" maxWidth="100%">
</p>


<p align="center">
<img src="https://user-images.githubusercontent.com/73280175/136690070-03a822a4-2646-48df-b6a4-9c706efd626a.gif" alt="simulator" width="20%">
</p>

---
<br>

## 소개
앱 'Martini' 는 자신만의 칵테일 레시피를 서로 공유하고 선호하는 칵테일을 쉽게 찾을 수 있도록 해주는 iOS 서비스 앱입니다.

<br>

---
<br>

## 목차
- [동작 과정](#동작-과정)
- [프로젝트 일정](#프로젝트-일정)
- [담당 역할](#담당-역할)
- [회고](#회고)
- [More Info](#more-information)

<br>

---
<br>

## 동작 과정
- 사용자는 앱의 서비스를 이용하기 위해서 반드시 로그인을 하여야 합니다. 로그인 혹은 회원가입을 위한 필수입력 항목을 공란으로 두었을 경우 이에 대한 알림으로 TextField 에 애니메이션 효과를 주어 보다 간편하게 자각할 수 있도록 하였습니다. 또한 사용자는 회원가입을 위한 절차에서 본인이 선호하는 칵테일의 베이스, 맛, 재료를 선택하여 앱에 해당 데이터를 제공합니다.
<br><br>
 

- 앱은 사용자의 칵테일 취향 선호 데이터를 참조하여 선호하는 맛과 선호하는 재료에 맞는 칵테일 레시피 데이터를 우선적으로 보여줄 수 있도록 적절한 정렬 알고리즘을 사용합니다. 각 칵테일 레시피 데이터는 스와이프를 하여 넘겨 볼 수 있으며 무한 스크롤링 방식으로 데이터는 반복되어 보여집니다.
<br><br>
 

- 자신이 찾는 이름의 칵테일이 있다면 이를 검색하여 보다 쉽게 찾을 수 있습니다. 또한 선호하는 칵테일 이외에 특정한 조건을 가지는 칵테일 레시피를 찾고 싶을 때는 맛과 색, 도수 등으로 해당하는 조건에 충족하는 칵테일 레시피를 찾을 수가 있습니다.
<br><br>
 

- 특정 칵테일 레시피가 마음에 들거나 나중에라도 참조해야 할 일이 있으면 이를 위하여 ‘찜’ 버튼을 눌러 개인 설정란에서 ‘찜 목록’ 으로 칵테일 레시피들을 확인할 수가 있습니다.
<br> <br>


- 사용자는 단순히 칵테일 레시피 정보를 제공받기에만 그치지 않고 본인만의 칵테일 제조법을 다른 사용자에게 공개(공유)할 수도 있습니다. 자신만의 특별한 칵테일을 만들어 개성있는 레시피를 남들에게 보여줄 수 있게 됩니다.

<br>

---
<br>

## 프로젝트 일정

<p align="center">
<img src="https://user-images.githubusercontent.com/73280175/136690821-ace8f631-4ade-461b-9e1b-672329190a30.png" alt="단체사진" width="80%">
</p>

---
<br>

## 담당 역할

- 임진규
  - 초기 데이터 모델 디자인
  - 조건검색 화면 구현
  - 세팅화면 구현
  - 전체적인 화면 연결 구현
  - <details><summary>구현 코드</summary>
    
    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Model/User.swift">User.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Model/Cocktail.swift">Cocktail.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Button/ColorButton.swift">ColorButton.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Button/VStackButton.swift">VStackButton.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/CocktailTableViewCell/CockTailTableViewCell.swift">CockTailTableViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/ImageView/WebImageView.swift">WebImageView.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Table/CustomTableView.swift">CustomTableView.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/CocktailMain/CocktailMainViewController.swift
    ">CocktailMainViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Detail/DetailViewController.swift
    ">DetailViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Main/ViewController.swift
    ">ViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Setting/AppSettingViewController.swift
    ">AppSettingViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Setting/MyInfoViewController.swift
    ">MyInfoViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Setting/SettingViewController.swift
    ">SettingViewController.swift</a></p>
    
    </details>
<br>

- 최예주
  - 전체적인 앱의 UI 및 로직 기획
  - 메인 화면 뷰와, 무한 스크롤 기능 구현
  - 칵테일을 검색할 수 있는 뷰, 상세화면 뷰 구현
  - <details><summary>구현 코드</summary>
    
    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Button/BannerButton.swift">BannerButton.swift</a></p>
    
    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/DetailTableViewCell/DetailTableViewCell.swift">DetailTableViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/IngredientTableViewCell/ingredientTableViewCell.swift">ingredientTableViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/MainAttributeTableViewCell/MainAttributeTableViewCell.swift">MainAttributeTableViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/MainTableViewCell/MainTableViewCell.swift">MainTableViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/RecipeTableViewCell/RecipeTableViewCell.swift">RecipeTableViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/TasteTableViewCell/TasteTableViewCell.swift">TasteTableViewCell.swift</a></p>
    
    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Progress/TasteProgressView.swift
    ">TasteProgressView.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/CocktailMain/CocktailMainViewController.swift
    ">CocktailMainViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Search/SearchViewController.swift
    ">SearchViewController.swift</a></p>


    </details>
<br>

- 이상현
  - 로그인, 회원가입 뷰 구현
  - 로그인 과정에서 파이어 베이스에 등록된 이메일, 비밀번호를 확인하여 로그인하는 로직 구현
  - 회원가입 과정에서 파이어 베이스에 이메일, 휴대전화번호, 이메일, 비밀번호를 등록하는 로직 구현 
  - <details><summary>구현 코드</summary>
    
    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Button/BannerToggleButton.swift">BannerToggleButton.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Button/LoginButton.swift">LoginButton.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/TextField/CustomInputTextField.swift">CustomInputTextField.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Extension/String%2BValidation.swift">String%2BValidation.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Auth/LoginViewController.swift">LoginViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/Auth/SignUpViewController.swift">SignUpViewController.swift</a></p>
    
    </details>
<br>

- 김영현(RONICK)
  - 회원 가입 과정에서 유저의 칵테일 베이스, 재료, 맛의 선호도를 등록하는 로직과 뷰 구현
  - 파이어 베이스(Firebae)를 이용하여 유저와 칵테일의 데이터 연동 로직 구현
  - 유저의 칵테일 선호도에 따른 칵테일 레시피 정렬 알고리즘 구현
  - 칵테일 레시피를 등록하는 로직과 뷰 구현
  - <details><summary>구현 코드</summary>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/API/ImageUploader.swift">ImageUploader.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Button/LikeButton.swift">LikeButton.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/BasePreferenceCell/BasePreferenceCollectionViewCell.swift">BasePreferenceCollectionViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/ColorSelectionCell/ColorSelectionCollectionViewCell.swift">ColorSelectionCollectionViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/FlavorPreference/FlavorPreferenceCollectionViewCell.swift">FlavorPreferenceCollectionViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Cell/IngredientsSelectionCell/IngredientsSelectionCollectionViewCell.swift">IngredientsSelectionCollectionViewCell.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Component/Slider/SliderStrenth.swift">SliderStrenth.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/DataStore/DataStore.swift">DataStore.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Firebase/AuthManager.swift">AuthManager.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Firebase/CocktailManager.swift">CocktailManager.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Utils/Constants.swift">Constants.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/Utils/ImagePickerViewController.swift">ImagePickerViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/BasePreference/BasePreferenceViewController.swift">BasePreferenceViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/ColorSelection/ColorSelectionViewController.swift">ColorSelectionViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/FlavorPreference/FlavorPreferenceViewController.swift">FlavorPreferenceViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/IngredientPreference/IngredientsSelectionViewController.swift">IngredientsSelectionViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/PreferenceComplete/PreferenceCompleteViewController.swift">PreferenceCompleteViewController.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/UploadRecipe/CocktailRecipeShare.swift">CocktailRecipeShare.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/UploadRecipe/RecipeStepHandler.swift">RecipeStepHandler.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/UploadRecipe/UploadRecipeKeyboardHandler.swift">UploadRecipeKeyboardHandler.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/UploadRecipe/UploadRecipeTextDelegate.swift">UploadRecipeTextDelegate.swift</a></p>

    <p><a href = "https://github.com/ronick-grammer/Martini/blob/main/Martini/View/UploadRecipe/UploadRecipeViewController.swift">UploadRecipeViewController.swift</a></p>

    </details>

    

<br>

----
<br>

## 회고

- 임진규<br>
  앱을 제작하는 과정중에 가장 어려웠던건 협업하는 과정이었다. Xcode에서 iOS앱을 생성할 경우 기본적으로 생선되는 시스템 파일들에 대한 이해가 많이 부족했다. 기본적으로 asset파일과 project파일 따로 관리된다는걸 몰랐다. 또한 4명에 개발자가 git workflow작업방식을 따르면서 merge conflict이슈가 너무나도 두려웠다. (대표적으로 project.pbxproj 파일)
  이후 Xcode에서 생성되는 시스템 파일에 대한 이해가 생겼고 xcodegen이라는 project생성 툴을 이용한 이후 merge이슈들이 해결 가능한 수준이 되었다.
  <br><br>
  다른 한 가지에 대해 깨달은건 기초가 많이 부족하다는 것이었다. custom 컴포넌트를 만드면서 여태까지 init을 제대로 구현안하고 있었다. tableViewCell안에 버튼을 만들어 cell을 사용하는 화면에서 addTarget으로 이벤트를 전달할때 데이터를 전달하는 방법이 쉽게 안떠오른다. 실습 위주보다 좀더 기초적인 공부에 신경써야할거같다.
<br><br>

- 김영현(RONICK)<br>
    처음으로 협업하는 프로젝트라 어색하긴 하였지만 정말 많은 것을 배우게 되었다. 혼자서 만드는 것보다 여럿이서 협업을 하여 개발을 한다는 것이 더욱더 어려운 일이라는 것을 몸소 알게 되었다. UI 기획안을 만들기 위한 피그마(Figma) 작업, 프로젝트의 스케줄과 ToDo 리스트를 관리하기 위한 트렐로(Trello) 그리고 깃 워크플로우를 바탕으로 프로젝트의 버전 관리를 함으로써 협업의 과정과 중요성을 알게 되었다.
<br><br>

- 최예주<br>
   기획부터, 개발 순서, 데이터베이스 연동 등 이번 프로젝트를 통해 앱을 하나 만들기 위한 흐름을 파악할 수 있었다. 
   또, 같은 기능을 구현할때도 어떤 방법이 더 좋은지 고민해 볼 수 있었고, 예상치 못한 어려움도 있었지만 이를 해결해보면서 개발자로서 한 단계 더 성장하는 계기가 될 수 있었다.
<br><br>

- 이상현<br>
  우선 생각했던 시일보다 훨씬 늘어났지만 무사히 마칠 수 있어서 감사합니다.
  iOS를 이용한 첫 번째 협업 프로젝트였는데  Figma를 이용한 기획, Trello를 이용한 소통, 프로젝트 파일의 충돌 해결을 위해 XcodeGen을 경험해보면서 현업에서 사용하는 툴 들을 경험해볼 수 있었습니다.
  이번 경험을 통해서 iOS 개발에 대한 지식은 물론 깃을 사용함에 있어서의 유의사항, 브랜치 사용법을 배울 수 있었고 다양한 문제 및 충돌을 해결법에 대해서도 익숙해질 수 있었습니다.
  무엇보다 iOS 개발이라는 공통 주제로 각자의 고민및 고충을 토로하고 다양한 정보를 공유할 수 있는 동료가 생겼다는 것이 가장 감사합니다.

<br>

---
<br>

## More Information 
Martini 앱의 기획, 일정이 궁금하시면 아래 뱃지를 클릭해주세요.
<br><br>

<p align="left">

<a href = "https://www.figma.com/file/Re7BHjB9KWIdsmY3EFdwzt/Project-Martini?node-id=0%3A1">
<img src="https://img.shields.io/badge/-Figma-000000?style=flat&logo=Figma" alt="figma" width = "10%" maxWidth="100%">
</a>

<a href = "https://trello.com/b/qcapcQKI/project-martini">
<img src="https://img.shields.io/badge/-Trello-000000?style=flat&logo=Trello" alt="trello" width = "10%" maxWidth="100%">
</a>

</p>

<br>

---
<br>

## Martini 팀원들 : )
<br><br>
<table align="center">
  <tr>
    <td align="center"><a href="https://github.com/ronick-grammer"><img src="https://avatars3.githubusercontent.com/u/73280175?v=4?s=100" width="50" alt="Avatar"/><br /><sub><b>김영현</b></sub></a></td>
    <td align="center"><a href="https://github.com/ijg0341"><img src="https://avatars2.githubusercontent.com/u/51219477?v=4?s=100" width="50" alt="Avatar"/><br /><sub><b>임진규</b></sub></a></td>
    <td align="center"><a href="https://github.com/yi-sang"><img src="https://avatars3.githubusercontent.com/u/80687913?v=4?s=100" width="50" alt="Avatar"/><br /><sub><b>이상현</b></sub></a></td>
    <td align="center"><a href="https://github.com/asqw887"><img src="https://avatars3.githubusercontent.com/u/59790540?v=4?s=100" width="50" alt="Avatar"/><br /><sub><b>최예주</b></sub></a></td>
  </tr>
  
</table>

<p align="center">
<img src="https://user-images.githubusercontent.com/80687913/135737067-38d682c7-4454-42f9-b703-14337cbdd313.jpeg" alt="단체사진" width="60%">
</p>
