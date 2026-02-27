# Release Checklist

## A. 문서/정책

1. `README.md` 최신화
2. `CONTRIBUTING.md`(존재 템플릿) 최신화
3. `docs/oss/*` 점검

## B. 라이선스 일관성

1. 루트 `LICENSE` 확인
2. `templates/*/*/LICENSE` 확인
3. `package.json`의 `"license": "Apache-2.0"` 확인

## C. 공개 전 검증

1. 민감정보 스캔
2. 개인식별 링크/값 치환 확인
3. 불필요 추적 파일 제거 확인

## D. 배포

1. 변경 커밋/푸시
2. GitHub Visibility `Public`
3. 릴리스 노트/태그 작성
