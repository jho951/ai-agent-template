# Sanitization Checklist

## 1) 민감정보 점검

- API 키/토큰/개인키 포함 여부 검색
- `.env`/로컬 설정 파일 추적 여부 확인

## 2) 개인식별 정보 점검

- 개인 이메일/개인 도메인/개인 SNS 링크 포함 여부 확인
- 템플릿 내 값은 플레이스홀더로 유지

## 3) 개발환경 흔적 점검

- `.idea/`, `.vscode/`, `.DS_Store` 추적 여부 확인
- 빌드 아티팩트/로그 파일 추적 여부 확인

## 4) 자동 점검 예시

```bash
rg -n --hidden --glob '!**/.git/**' \
'(AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|BEGIN (RSA|EC|OPENSSH|DSA) PRIVATE KEY|api[_-]?key\\s*=|token\\s*=|secret\\s*=)' .
```
