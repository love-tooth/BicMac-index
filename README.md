# MySQL-ELK-mini-project

## 🌍 프로젝트 개요 
본 프로젝트는 Ubuntu 환경에서 Logstash를 활용해 MySQL과 ElasticSearch를 연동하고, Kibana를 활용한 시각화를 통해 나라별 빅맥 지수와 최저 임금, 관광 데이터 간의 유의미한 인사이트 도출을 목표로 합니다. 


## 🛠️ 개발구성원 
<table>
  <tbody>
    <tr>
      <td align="center">
         <a href="https://github.com/yeejkim">
          <img src="https://github.com/yeejkim.png" width="200px;" alt=""/>
          <br /><sub><b> 김예진 </b></sub>
        </a>
        <br />
      </td>
      <td align="center">
          <a href="https://github.com/HyunDooBoo">
          <img src="https://github.com/HyunDooBoo.png" width="200px;" alt=""/>
          <br /><sub><b> 오현두 </b></sub>
        </a>
        <br />
      </td>
      <td align="center">
        <a href="https://github.com/imhaeunim">
          <img src="https://github.com/imhaeunim.png" width="200px;" alt=""/>
          <br /><sub><b> 임하은 </b></sub>
        </a>
        <br />
      </td>
      <td align="center">
        <a href="https://github.com/BlueRedOrange">
          <img src="https://github.com/BlueRedOrange.png" width="200px;" alt=""/>
          <br /><sub><b> 정파란 </b></sub>
        </a>
        <br />
      </td>
    </tr>
  </tbody>
</table>

<br> 

## 📌 목차

1. [**빅맥 지수란?**](#-빅맥-지수big-mac-index란)
2. [**시각화**](#-kibana-시각화)
3. [**아키텍처**](#-아키텍처)  
4. [**데이터**](#-데이터)
5. [**트러블슈팅**](#-트러블슈팅)
6. [**회고**](#회고)

<br> 

## 🍔 빅맥 지수(Big Mac index)란?
  - 전 세계 각국의 맥도날드 매장에서 팔리는 빅맥 가격을 달러로 환산한 수치
  - 장기의 환율결정 이론에 따르면 국제거래에 아무런 제약이 없을 경우 서로 다른 국가들에서 팔리고 있는 동일한 품질의 재화는 하나의 통화로 가격을 표시했을 때 가격에 차이가 없어야 한다.
  - 즉, 환율은 각 통화의 구매력이 같게 되도록 결정되어야 한다는 것이다. 
  - 빅맥지수는 각국의 빅맥 햄버거 가격을 미국에서의 가격과 같게 만들어주는 환율을 의미한다. 
  - 실제 환율이 이보다 낮으면 해당 국가의 통화는 고평가되어있고 반대로 높으면 저평가되어 있음을 나타낸다.

<br>

## 📊 Kibana 시각화
- 한국 빅맥지수 (미국 기준)


  <img src="https://github.com/user-attachments/assets/14f3efae-3f86-4aee-8eaa-3905ef218322" alt="한국 빅맥지수" width="700">


  - 빅맥 지수가 지속적으로 떨어지는 것을 확인할 수 있다.
  - 빅맥지수가 낮다 → 환율이 높다 → 대한민국 화폐 가치 낮게 평가된다. 

- 년도별 대한민국 빅맥 가격 (달러로 변환)
  <img src="https://github.com/user-attachments/assets/b792876e-e212-43b0-8e70-52809774447c" alt="년도별 대한민국 빅맥 가격" width="700">
  

- 한국과 미국 빅맥 가격

  <img src="https://github.com/user-attachments/assets/15a70459-2d27-4e41-9c6c-9cd84d7fd176" alt="한국과 미국 빅맥 가격" width="700">

  
- 한달 최저임금으로 구매할 수 있는 빅맥 개수
  
  - 2000년~2018년 평균

    <img src="https://github.com/user-attachments/assets/4c252135-4ca0-4c2f-b99f-b11d88372415" alt="2000년~2018년 평균" width="700">

    - 2000년~2018년까지 월 최저 임금으로 구입할 수 있는 빅맥 수를 비교해봤을 때, 한국과 미국이 비슷한 것을 확인할 수 있다.
    - 현지인 입장에서 빅맥 가격은 비슷하다고 결론을 내릴 수 있다.
   

  - 2018년 기준
 
    <img src="https://github.com/user-attachments/assets/6767a8a2-daaf-4f1b-80fc-424f6d3ed0dd" alt="2018년 기준" width="700">
    
    
    - 2018년 데이터만으로 봤을 때, 한국 수치가 미국보다 높은 것을 확인할 수 있다.
    - why?
      - 미국은 2009년부터 15년동안 최저임금이 동결되었다.
      - 또한, 미국은 팁의 수익이 높기 때문에 확실한 분석을 위해서는 최저임금이 아닌 평균 수입으로 비교해야 했다.
    
- 관광 수입과 빅맥지수

   <img src="https://github.com/user-attachments/assets/49bf0da9-6b00-4549-b4d0-21500deae109" alt="한국과 미국 빅맥 가격" width="700">
   
  - 관광 수입이 많아지면 외화 유입률이 높아지고 빅맥지수도 함게 높아지는 것을 확인할 수 있다. 

<br>


## 🚀 아키텍처 
![Flowcharts](https://github.com/user-attachments/assets/200c513a-145e-4577-abb4-b5318bf16903)



1. **데이터 저장:** MySQL 데이터베이스에 최종 데이터셋 csv 파일 import 
2. **Logstash 동기화:** Logstash의 JDBC 드라이버를 통해 MySQL에서 ES로 데이터를 1분 간격으로 스케쥴링 자동화
    <details>
    <summary>conf 파일 설정</summary>
    
    - **입력(Input):** MySQL 데이터베이스에서 데이터를 가져오는 JDBC 설정
    - **필터(Filter):** 필요한 데이터만 추출하고 가공
    - **출력(Output):** ElasticSearch로 데이터 전송
  
    ```plaintext
    input {
      jdbc {
        jdbc_connection_string => "jdbc:mysql://localhost:3306/bigmac_db"
        jdbc_user => "root"
        jdbc_password => "password"
        jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
        schedule => "* * * * *"
        statement => "SELECT * FROM bigmac_table WHERE timestamp > :sql_last_value"
        use_column_value => true
        tracking_column => "timestamp"
      }
    }
    
    output {
      elasticsearch {
        hosts => ["http://localhost:9200"]
        index => "bigmac_index"
      }
    }
    ```
    
    - 스케줄링 설정
      - Logstash는 `schedule` 옵션을 사용하여 1분마다 데이터 동기화
    <details>
    <summary>conf 파일 설정</summary>
    

3. **데이터 시각화:** Kibana 통한 데이터 시각화 및 인사이트 도출

<br>

## 🛠️ 사용 기술 스택 
- **데이터베이스:** MySQL
- **동기화 도구:** Logstash (JDBC Driver 활용)
- **검색 및 분석 엔진:** ElasticSearch
- **시각화 도구:** Kibana
- **언어:** SQL, JSON
- **자동화 도구:** Logstash 스케줄링

<br>

## 📝 디렉토리 구조
```
├── logstash_config/
│   └── big_mac_unix.conf
│   └── big_mac_interval.conf
│   └── big_mac_convert_tz.conf
├── sql_scripts/
│   └── create_bigmac_table.sql
├── data/
│   └── bid_mac_wage_tour.csv
└── README.md
```

<br>

## 🗂️ 데이터
### 활용 데이터셋 
1. [Big Mac Index Data](https://www.kaggle.com/datasets/mrmorj/big-mac-index-data)
  - 각국의 맥도날드에서 제공하는 빅맥 가격과 전 세계의 보고서를 기반으로 구성된 데이터셋

    | 컬럼명 | 설명 |
    |:---:|:---:|
    | date | 날짜 |
    | iso_a3 | 국가의 3자리 ISO 국가 코드 |
    | currency_code | 해당 국가의 통화 코드 |
    | name | 국가명 |
    | local_price | 해당 국가에서의 빅맥 가격 (현지 통화 기준) |
    | dollar_ex | 해당 국가 통화와 미국 달러 간의 환율 |
    | dollar_price | 미국 달러 기준의 빅맥 가격 |
    | USD_raw | 원래 미국 달러 가격 (원가) |
    | EUR_raw | 원래 유로 가격 (원가) |
    | GBP_raw | 원래 파운드 가격 (원가) |
    | JPY_raw | 원래 엔 가격 (원가) |
    | CNY_raw | 원래 위안 가격 (원가) |
    | GDP_dollar | 해당 국가의 GDP (미국 달러 기준) |
    | adj_price | 조정된 가격 (환율 변동 등을 반영한 가격) |
    | USD_adjusted | 조정된 USD 가격 |
    | EUR_adjusted | 조정된 EUR 가격 |
    | GBP_adjusted | 조정된 GBP 가격 |
    | JPY_adjusted | 조정된 JPY 가격 |
    | CNY_adjusted | 조정된 CNY 가격 |
    

2. [Minimum Wages between 2001 & 2018](https://www.kaggle.com/datasets/frtgnn/minimum-wages-between-2001-2018)
  - 각국의 2001년부터 2018년 사이의 최저 임금 데이터셋
  - 연도, 나라명, 최저임금 데이터로 구성
  - 예시 데이터 

    | Country   | 2001   | 2002   | 2003   | 2004   | 2005   |
    |-----------|--------|--------|--------|--------|--------|
    | Australia | 20664.4| 20867.9| 21140.2| 21511.3| 21685.7|
    | Belgium   | 21651.3| 21941.5| 21814.6| 21578.3| 21413.6|
    | Canada    | 14205.3| 14056.0| 13858.6| 13880.8| 14002.8|
    | Chile     | 4507.9 | 4637.8 | 4701.6 | 4833.0 | 4925.8 |


3. [세계관광지표](https://know.tour.go.kr/stat/worldTourStatSummaryDis19Re.do)
  - 156개국을 대상으로 UN Tourism의 여행객수, 관광수입 및 관광지출 데이터셋
  - 연도, 나라명, 여행객수, 관광수입, 관광지출 데이터로 구성
  - 예시 데이터

    | 나라명                  | 2002년 | 2003년 | 2004년 | 2005년 |
    |-------------------------|--------|--------|--------|--------|
    | 세계(World)             | 709    | 697    | 761    | 809    |
    | 유럽(Europe)            | 407.4  | 408.6  | 420.8  | 452.9  |
    | 북유럽(Northern Europe) | 43.8   | 44.5   | 47.4   | 54.9   |
    | 덴마크(Denmark)         | 2      | 3.5    | 4.4    | 9.2    |


### 데이터 전처리
- 문제 상황 
  - 위 2, 3번 데이터셋의 경우, **교차 테이블(Cross-Tabulation Table)** 형식으로 이루어져 있었음

- 데이터 전처리 
  - **행지향(Row-oriented)** 형식으로 변경

    <details>
      <summary>코드</summary>
    
    ```python
    # 관련된 행에서 연도 정보 추출
    arrival_years = data.iloc[0, 2:21].values  # C부터 U 열까지
    income_years = data.iloc[0, 21:40].values  # V부터 AN 열까지
    expenditure_years = data.iloc[0, 40:59].values  # AO부터 BG 열까지
    
    # 관광객수, 수입, 지출 데이터 추출
    arrival_data = data.iloc[1:, 2:21]  # 2행부터 21열까지
    income_data = data.iloc[1:, 21:40]  # 2행부터 40열까지
    expenditure_data = data.iloc[1:, 40:59]  # 2행부터 59열까지
    
    # 국가 이름이 제대로 설정되도록 함
    arrival_data['country'] = data.iloc[1:, 1].values  # 국가 이름이 있는 열
    income_data['country'] = data.iloc[1:, 1].values
    expenditure_data['country'] = data.iloc[1:, 1].values
    
    # 각 데이터를 long format으로 변환
    arrival_long = arrival_data.melt(id_vars=['country'], var_name='year', value_name='visitors')  # 방문객수 데이터
    income_long = income_data.melt(id_vars=['country'], var_name='year', value_name='income')  # 수입 데이터
    expenditure_long = expenditure_data.melt(id_vars=['country'], var_name='year', value_name='outcome')  # 지출 데이터
    
    # 데이터 병합
    data_merged = pd.merge(arrival_long, income_long, on=['country', 'year'], how='outer')
    data_merged = pd.merge(data_merged, expenditure_long, on=['country', 'year'], how='outer')
    
    # CSV 파일로 저장
    output_path = 'tourism_data.csv'
    data_merged.to_csv(output_path, index=False)
    
    ```
    </details>

   
  
  - 각국의 이름과 연도 기준으로 하나의 테이블로 병합
 
  
### 최종 데이터셋 

- 컬럼명 및 설명

  | 컬럼명           | 설명                                      |
  |------------------|-------------------------------------------|
  | date             | 데이터가 기록된 날짜                      |
  | iso_a3           | 국가의 ISO 3166-1 Alpha-3 코드 (3자리 국가 코드) |
  | currency_code    | 국가의 통화 코드                          |
  | name             | 국가 또는 지역의 이름                     |
  | local_price      | 해당 국가에서의 현지 가격                 |
  | dollar_ex        | 해당 국가의 달러 환율                     |
  | dollar_price     | 달러 기준의 가격                          |
  | USD_raw          | 미국 달러로 변환한 원시 가격               |
  | EUR_raw          | 유로로 변환한 원시 가격                    |
  | GBP_raw          | 영국 파운드로 변환한 원시 가격             |
  | JPY_raw          | 일본 엔으로 변환한 원시 가격               |
  | CNY_raw          | 중국 위안화로 변환한 원시 가격             |
  | GDP_dollar       | 해당 국가의 GDP (미국 달러 기준)           |
  | adj_price        | 가격 조정 후 현지 가격                     |
  | USD_adjusted     | 달러로 조정된 가격                         |
  | EUR_adjusted     | 유로로 조정된 가격                         |
  | GBP_adjusted     | 영국 파운드로 조정된 가격                  |
  | JPY_adjusted     | 일본 엔으로 조정된 가격                    |
  | CNY_adjusted     | 중국 위안화로 조정된 가격                  |
  | min_wage         | 최저 임금                                  |
  | visitors         | 해당 국가를 방문한 여행객 수 (백만명 기준) |
  | income           | 관광 수입                                  |
  | outcome          | 관광 지출                                  |


- 예시 데이터 

  | date       | iso_a3 | currency_code | name        | local_price | dollar_ex | dollar_price | USD_raw  | EUR_raw  | GBP_raw  | JPY_raw  | CNY_raw  | GDP_dollar | adj_price | USD_adjusted | EUR_adjusted | GBP_adjusted | JPY_adjusted | CNY_adjusted | min_wage | visitors | income | outcome |
  |------------|--------|---------------|-------------|-------------|-----------|--------------|----------|----------|----------|----------|----------|------------|-----------|--------------|--------------|--------------|--------------|--------------|----------|----------|--------|---------|
  | 2000-04-01 | ARG    | ARS           | Argentina   | 2.5         | 1         | 2.5          | -0.00398 | 0.05007  | -0.16722 | -0.09864 | 1.09091  | 50000      | 2.6       | 2.4          | 2.3          | 2.5          | 2.7          | 2.6          | 450      | 15       | 2000   | 1500    |
  | 2000-04-01 | AUS    | AUD           | Australia   | 2.59        | 1.68      | 1.541666667  | -0.38579 | -0.35246 | -0.48645 | -0.44416 | 0.28939  | 100000     | 2.8       | 2.7          | 2.9          | 3.0          | 3.1          | 2.9          | 1800     | 20       | 2500   | 2000    |
  | 2000-04-01 | BRA    | BRL           | Brazil      | 2.95        | 1.79      | 1.648044693  | -0.34341 | -0.30778 | -0.45102 | -0.40581 | 0.37836  | 70000      | 3.0       | 2.9          | 3.1          | 3.2          | 3.3          | 3.1          | 500      | 18       | 2200   | 1800    |
  | 2000-04-01 | CAN    | CAD           | Canada      | 2.85        | 1.47      | 1.93877551   | -0.22758 | -0.18566 | -0.35417 | -0.30099 | 0.62152  | 80000      | 2.7       | 2.6          | 2.8          | 2.9          | 3.0          | 2.8          | 1500     | 25       | 3000   | 2500    |
  | 2000-04-01 | CHE    | CHF           | Switzerland | 5.9         | 1.7       | 3.470588235  | 0.3827   | 0.45774  | 0.15609  | 0.2513   | 1.90267  | 120000     | 3.5       | 3.3          | 3.6          | 3.7          | 3.8          | 3.6          | 3500     | 30       | 4000   | 3500    |

<br>

## 🐞 트러블슈팅 

### 문제 1: 데이터베이스와 연결 오류
- **문제**: MySQL 계정으로 데이터를 Logstash를 통해 Elasticsearch로 전송 실패

- **원인**: root 계정은 모든 권한을 다 가지고 있으나, 다른 프로그램과 연결시에 보안 상의 문제로 연결이 되지 않음 
- **해결 방법**
  - 새로운 사용자(user01)을 생성하여 권한 부여 후, 연결 진행
    <details>
    <summary>MySQL 사용자 생성 및 권한 부여 SQL</summary>

    ```sql
    CREATE USER 'user01'@'%' IDENTIFIED BY 'user01';
    GRANT SELECT ON your_database.* TO 'user01'@'%';
    FLUSH PRIVILEGES;
    ```
    </details>

<br>

### 문제 2: 데이터 타입 오류
- **문제**: 날짜 데이터인 'date' 컬럼이 날짜로 인식되지 않아, 날짜 필터링 및 시각화가 어려움
  
- **원인**: 'date'컬럼이 문자열(String)로 저장되어 있어 형식으로 변환이 필요함

- **해결 방법**
  - Logstash 설정 파일(.conf)에서 'date' 필드를 타임스탬프(timestamp) 형식으로 변환하기 위해 date 필터를 추가
  ``` logstash
    date {
      match => [ "date", "yyyyMMdd"]
      timezone => "Asia/Seoul"
      target => "date"
    }
  ```

<br>

### 문제 3 : 스케줄링 오류
- **문제** : logstash가 지속적으로 새로운 데이터를 받아오지 못함

- **원인** : 새로운 데이터를 구분할 수 있는 컬럼이 없음
  
- **해결 방법**
  - updated_at 컬럼을 생성하여, 이 컬럼 기준으로 이후 데이터만 가져오는 방식으로 해결
    ```slq
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ```
<br>

### 문제 4 : 서버 시간 불일치
- **문제** : logstash에 sql_last_value로 저장된 값과 updated_at을 비교할 수 없음
  
- **원인** : logstash의 시간은 UTC 기준이고 MySQL은 'Asia/Seoul' 기준으로 저장되어 있음
  
- **해결 방법**
  - **방법 1**
    - DATE_SUB 함수를 사용해 updated_at에 9시간을 빼서 계산함
    ```
      "SELECT * FROM big_mac_wage_tour where DATE_SUB(updated_at, INTERVAL 9 HOUR)> :sql_last_value;"
    ```
    - [big_mac_interval.conf](./logstash_conf/big_mac_interval.conf)
      
  - **방법 2**
    - CONVERT_TZ 함수를 사용해 DB에 Asia/Seoul 값으로 저장된 updated_at 를 UTC로 변환해서 비교
    ```
      "SELECT * FROM test WHERE CONVERT_TZ(updated_at, 'Asia/Seoul', 'UTC') > :sql_last_value"
    ```
    - 만약 DB가 설치된 환경에 Asia/Seoul 같은 시간대 정보가 없을 경우 (ubuntu 등)에는 tzdata 패키지를 설치 해야한다.
    ```
      sudo apt-get update
      sudo apt-get install tzdata
    ```
    - 이후 시스템을 재부팅 한 뒤 변경 사항을 적용한다.
    ```
      sudo reboot
      mysql 접속
      SELECT CONVERT_TZ(NOW(), 'Asia/Seoul', 'UTC') AS test_time_conversion;
    ```
    - [big_mac_convert_tz.conf](./logstash_conf/big_mac_convert_tz.conf)
      
  - **방법 3**
    - `unix_ts_in_secs` 표준 UNIX 타임스탬프를 사용해 타임스탬프를 일관되게 통일한다
    - `sql_last_value`를 통해 변경사항이 Elasticsearch에 적용된 삽입이나 업데이트가 Elasticsearch로 다시 전송되지 않도록 해준다.
    ```
    jdbc_paging_enabled => true
    tracking_column => "unix_ts_in_secs"
    use_column_value => true
    tracking_column_type => "numeric"
    schedule => "* * * * *"
    statement => "SELECT *, UNIX_TIMESTAMP(updated_at) AS unix_ts_in_secs FROM big_mac_wage_tour WHERE (UNIX_TIMESTAMP(updated_at) > :sql_last_value AND updated_at < NOW()) ORDER BY updated_at ASC"
    ```
    - [big_mac_unix.conf](./logstash_conf/big_mac_unix.conf)

<br>

## 🧐회고

- 김예진
  - ELK에 대해 처음 다뤄봤는데, 데이터 수집부터 시각화까지 진행할 수 있어 정말 재미있었습니다. 사실 처음에 MySQL과 연동하는 일이 쉬울 거라 생각했는데, 생각지도 못한 부분에서 트러블슈팅이 발생하여 어려웠습니다. 하지만 이 경험을 통해 값진 교훈을 얻었고, root 계정의 보안에 대해 다시 한 번 더 생각해볼 수 있었습니다.
    
- 오현두
  - 이번 프로젝트를 통해 데이터 수집, 전처리, 시각화의 전 과정을 경험하고, mySQL과 ELK와의 파이프 라인을 구축하며 데이터 관리 및 분석의 중요성을 다시금 깨달았습니다. 또, 팀원들과의 협업을 통해 다양한 인사이트를 도출할 수 있었고, 문제 해결 능력을 키울 수 있는 기회가 되었습니다. 앞으로도 이러한 경험을 바탕으로 더 나은 데이터 분석 프로젝트에 도전하고 싶습니다.
    
- 임하은
  - ELK를 사용해서 데이터를 실시간으로 처리하는 과정에서 일어나는 트러블슈팅을 통해 많이 성장할 수 있었던 거 같습니다. 또한 kibana를 통해 시각화를 하는 과정에서 원하는 index를 만들고 그래프를 구성하는 방법을 배우며, 데이터를 시각적으로 표현하는 방식이 효율적인 수단임을 실감할 수 있었습니다. 
- 정파란
  - Elastic Search와 mysql에서 각각 데이터를 다룰 때 최대한 에러가 발생하지 않도록 데이터 타입들을 명시적으로 정하고, 그에 맞춰서 처리하는 것이 중요하다는 걸 알 수 있었습니다. 데이터의 처리와 시각화 뿐만 아니라 유의미한 인사이트를 도출해내는 과정에서 많은 토의 가 필요하였고 데이터 그 자체보다 데이터에서 무엇을 알 수 있는지 생각하는 능력을 기르게 되었습니다.

<br>

## 📚 참고 자료 
- [ElasticSearch 공식 문서](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Logstash JDBC Input Plugin](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html)
- [빅맥 지수 위키백과](https://en.wikipedia.org/wiki/Big_Mac_Index)
