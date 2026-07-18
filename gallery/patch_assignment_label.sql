-- 4일차 필터 라벨 변경: "기온 예측기" → "머신러닝 프로젝트" (2026-07-18, 순서 수정판)
-- 반드시 이 순서로: 제약 제거 → 값 변경 → 새 제약 추가 (반대로 하면 옛 제약이 새 값을 거부함)
alter table public.apps drop constraint if exists apps_assignment_check;

update public.apps set assignment = '4일차 머신러닝 프로젝트'
  where assignment = '4일차 기온 예측기';

alter table public.apps add constraint apps_assignment_check
  check (assignment in (
    '1일차 MBTI 페이지',
    '2일차 인구 대시보드',
    '3일차 AI 채팅앱',
    '4일차 머신러닝 프로젝트',
    '5일차 최종 프로젝트'
  ));
