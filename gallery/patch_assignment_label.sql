-- 4일차 필터 라벨 변경: "기온 예측기" → "머신러닝 프로젝트" (2026-07-18)
-- 라이브 DB의 CHECK 제약을 새 라벨로 교체한다. (기존 제출 행이 있으면 먼저 UPDATE)
update public.apps set assignment = '4일차 머신러닝 프로젝트'
  where assignment = '4일차 기온 예측기';

alter table public.apps drop constraint if exists apps_assignment_check;
alter table public.apps add constraint apps_assignment_check
  check (assignment in (
    '1일차 MBTI 페이지',
    '2일차 인구 대시보드',
    '3일차 AI 채팅앱',
    '4일차 머신러닝 프로젝트',
    '5일차 최종 프로젝트'
  ));
