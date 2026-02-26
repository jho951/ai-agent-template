# 프로젝트 템플릿 저장소

이 저장소와 포함 템플릿은 Apache License 2.0로 공개됩니다. 자세한 내용은 [LICENSE](./LICENSE)를 확인하세요.

이 저장소는 `4가지 타입`과 `3단계 성숙도` 템플릿을 제공합니다.

```text
templates/
  backend-module/
    min/
    std/
    ext/
  service-api/
    min/
    std/
    ext/
  frontend-ui/
    min/
    std/
    ext/
  ml-data/
    min/
    std/
    ext/
scripts/
  new.sh
README.md
```

핵심 협업 축(공통):

- 요구사항 문서: `docs/REQUIREMENTS.md`
- 의사결정 기록(ADR): `docs/decisions/*.md`
- 프롬프트 자산: `prompts/*`
- 실행/장애 가이드: `docs/runbook/DEBUG.md`

## 단계별 기준

### Min

- `AGENTS.md`, `README.md`
- `docs/REQUIREMENTS.md`
- `docs/decisions/000-adr-template.md`
- `docs/runbook/DEBUG.md`
- `prompts/README.md`, `prompts/0-initial-setup.md`
- `prompts/plans/000-plan-template.md`
- `.editorconfig`, `.gitignore`

### Std (Min + 협업/품질 게이트)

- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/workflows/ci.yml`
- `CONTRIBUTING.md`
- `docs/decisions/`, `docs/runbook/` 확장

### Ext (Std + 운영/배포/거버넌스)

- `CHANGELOG.md`, `SECURITY.md`, `CODEOWNERS`
- `docs/architecture/`, `docs/operations/`, `docs/threat-model/`
- `.github/workflows/release.yml`

## 타입별 추가 구성

### `backend-module`

- Min: `src/main`, `src/test`, `build.gradle`, `LICENSE`
- Std: `docs/api`, `docs/compat`, `examples`
- Ext: `docs/migration`, `docs/perf`

### `service-api`

- Min: `src/main`, `src/test`, `package.json`, `docs/api/README.md`
- Std: `docs/api/openapi.yml`, `docs/operations/*`, `docker-compose.yml`
- Ext: `docs/operations/SLO.md`, `alerts.md`, `incident-runbook.md`, `loadtest/`

### `frontend-ui`

- Min: `src/components`, `src/pages`, `package.json`, `docs/ui/README.md`
- Std: `docs/ui/design-tokens.md`, `docs/ui/component-guidelines.md`, `docs/accessibility/checklist.md`, `tests/`
- Ext: `tests/e2e`, `docs/perf`, `docs/release`

### `ml-data`

- Min: `src`, `notebooks`, `data/README.md`, `models/README.md`, `requirements.txt`
- Std: `experiments/`, `repro/run.sh`, `docs/evaluation/`, `docs/data-quality/`
- Ext: `docs/model-card.md`, `docs/data-card.md`, `docs/monitoring/`, `pipelines/`

## 사용 방법 A: 로컬 복사 후 새 저장소 초기화

1. 템플릿 저장소를 클론합니다.

```bash
git clone https://github.com/<YOU>/project-templates.git
cd project-templates
```

2. 새 프로젝트 폴더를 만들고 템플릿을 복사합니다.

예시: `service-api/std`로 `my-service` 생성

```bash
mkdir -p ../my-service
cp -R templates/service-api/std/. ../my-service/
```

3. 새 프로젝트에서 Git 초기화 후 원격을 연결합니다.

```bash
cd ../my-service
git init
git add -A
git commit -m "chore: init from service-api std template"
git remote add origin git@github.com:<YOU>/my-service.git
git push -u origin main
```

## 사용 방법 B: `scripts/new.sh` 사용 (권장)

실행 권한 1회 부여:

```bash
chmod +x scripts/new.sh
```

기본 실행:

```bash
./scripts/new.sh <type> <tier> <name> [--git-init] [--gh-private]
```

예시 1: 생성 + Git 초기화/첫 커밋

```bash
./scripts/new.sh service-api std my-service --git-init
```

예시 2: 생성 + Git 초기화 + GitHub private 레포 생성/푸시

```bash
./scripts/new.sh service-api std my-service --gh-private
```

## 운영 팁

- 템플릿 수정은 이 저장소에서만 수행합니다(단일 진실원).
- 생성된 프로젝트는 템플릿과 자동 동기화되지 않습니다.
- 중요한 개선사항은 각 프로젝트에 선택적으로 반영합니다.
