USE wbdb;

-- 사용자(User) 테이블 생성
CREATE TABLE
    IF NOT EXISTS User (
        UserID INT PRIMARY KEY,
           Name VARCHAR(50),
        ResidentRegistrationNumber VARCHAR(13),
        ContactNumber VARCHAR(14),
        Address VARCHAR(100),
        Email VARCHAR(50)
    );

-- -- 복무 현황(ServiceStatus) 테이블 생성
-- CREATE TABLE ServiceStatus (
--     ServiceID INT PRIMARY KEY, UserID INT, StartDate DATE, EndDate DATE, ServiceContent VARCHAR(100), ServiceArea VARCHAR(50), ServiceStatus VARCHAR(50), FOREIGN KEY (UserID) REFERENCES User (UserID)
-- );
-- -- 보고서(Report) 테이블 생성
-- CREATE TABLE Report (
--     ReportID INT PRIMARY KEY, UserID INT, ReportDate DATE, ReportType VARCHAR(50), ReportContent VARCHAR(200), AdditionalReportInformation VARCHAR(200), FOREIGN KEY (UserID) REFERENCES User (UserID)
-- );
-- 사용자(User) 테이블에 데이터 삽입
INSERT INTO
    User (UserID, Name, ResidentRegistrationNumber, ContactNumber, Address, Email)
VALUES
    (3, '장발장', '123456-1234567', '01012345678', '서울시 강남구', 'bal@gmail.com'),
    (5, '장손장', '101010-2222222', '01022223333', '경기도 남양주시', 'son@gmail.com'),
    (6, '장눈장', '123456-5656565', '01099991111', '대전시 유성구', 'noon@naver.com');

-- -- 복무 현황(ServiceStatus) 테이블에 데이터 삽입
-- -- 예시 데이터, 실제 데이터에 맞게 수정 필요
-- INSERT INTO
--     ServiceStatus (
--         ServiceID, UserID, StartDate, EndDate, ServiceContent, ServiceArea, ServiceStatus
--     )
-- VALUES (
--         1, 1, '2023-01-01', '2023-12-31', '군 복무', '서울', '완료'
--     );
-- -- 보고서(Report) 테이블에 데이터 삽입
-- -- 예시 데이터, 실제 데이터에 맞게 수정 필요
-- INSERT INTO
--     Report (
--         ReportID, UserID, ReportDate, ReportType, ReportContent, AdditionalReportInformation
--     )
-- VALUES (
--         1, 1, '2023-12-31', '연차 보고서', '2023년 복무 보고서', '연차 복무에 대한 상세 내용'
--     );
-- -- 데이터 삽입 후 확인을 위해 각 테이블 조회
-- SELECT * FROM User;
-- SELECT * FROM ServiceStatus;
-- SELECT * FROM Report;
