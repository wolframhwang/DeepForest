# DeepForest

iOS Native 커뮤니티 앱

사용된 오픈 소스
- RxSwift
- RxCocoa
- SnapKit
- FlexLayout
- PinLayout
- Alamofire
- RxDataSources

최대한 Clean Architecture 에서 지향하는 디자인 패턴을 유지하려고 노력했다
하지만 때때로, 비즈니스로직을 사용하기 위해서, UseCase를 따로 만드는것이 Cost가 더 들겠다고 판단되는 부분들은 과감히 생략하였다.

## Auth

| Choice | SignIn | SignUp |
| ------ | ------ | ------ |
| <img width="481" alt="스크린샷 2022-09-19 오전 1 20 02" src="https://user-images.githubusercontent.com/29563788/190917369-11354a64-caf4-4ccd-930d-3e0877dcb9b8.png"> |  <img width="514" alt="스크린샷 2022-09-19 오전 1 27 49" src="https://user-images.githubusercontent.com/29563788/190917690-7fa10fcf-3d87-415e-95f9-599d2049ba75.png"> |  <img width="466" alt="스크린샷 2022-09-19 오전 1 28 07" src="https://user-images.githubusercontent.com/29563788/190917695-edc57e1d-4962-43e2-b45d-30a4f346843e.png"> |


## HomeScene

- 아직 진행 중, 인기 게시글을 List화 + Search 기능 구현 예정

| HomeScene |
| --------- |
| <img width="468" alt="스크린샷 2022-09-19 오전 1 31 19" src="https://user-images.githubusercontent.com/29563788/190917848-5019838d-334e-44cc-8cda-9b0c0eb0e526.png"> |

## HomeScene to OtherScene

- 홈 to 갤러리 리스트 -> 갤러리까지
- 홈 to Setting Scene 

| Home Scene To Other |
| -------------------- |
|  ![6ttrvf](https://user-images.githubusercontent.com/29563788/190918553-a7c94aad-b8d0-4031-8137-d4466b3290d9.gif) |

## In-GalleryScene


| GalleryScene1 | GalleryScene2 |
------------- | ------------- |
| ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 01 42 05 mp4](https://user-images.githubusercontent.com/29563788/190918980-a036da80-23f7-477b-a598-d234fe99a023.gif)  |  ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 01 43 38 mp4](https://user-images.githubusercontent.com/29563788/190919031-15fc7d8e-48ec-41b9-82d9-be385acba9cf.gif) |


## WritePostScene

| WritePostScene1 | WritePostScene2 |
| --------------- | --------------- |
|  ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 01 57 13 mp4](https://user-images.githubusercontent.com/29563788/190919284-0f39b8b1-f6f2-4277-b6de-1509423c699a.gif) | ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 01 58 50 mp4](https://user-images.githubusercontent.com/29563788/190919393-9240d2c8-e5eb-4c78-af4b-e7cfb9ef099f.gif) |

## PostViewScene

| PostViewGeneral | PostViewWithComment | PostViewManySize1 | PostViewManySize2 |
| --------------- | ------------------- | ----------------- | ----------------- |
| ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 02 06 04 mp4](https://user-images.githubusercontent.com/29563788/190919642-3a3e7c5d-2d89-40ee-b512-195ec7f2bf42.gif) | ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 02 09 07 mp4](https://user-images.githubusercontent.com/29563788/190919664-fad0a355-32ea-4534-a736-8d12a7d738ba.gif) | ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 02 10 50 mp4](https://user-images.githubusercontent.com/29563788/190919786-708189f6-e193-4830-b9ca-c8698f1339d2.gif) | ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 02 11 45 mp4](https://user-images.githubusercontent.com/29563788/190919796-41248cbc-70bb-4fc1-8a2e-c76a077bb446.gif) |

| WriteComment In PostView1 | WriteComment In PostView2 |
| ------------------------- | ------------------------- |
| ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 02 16 01 mp4](https://user-images.githubusercontent.com/29563788/190920015-d35f9d73-b899-42cd-b528-80206e558539.gif) | ![Simulator Screen Recording - iPhone 12 Pro - 2022-09-19 at 02 17 51 mp4](https://user-images.githubusercontent.com/29563788/190920046-604a7033-6892-42ab-9379-4916d2d22eb2.gif) |




