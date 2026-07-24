-- ============================================================
-- 병아리반 작품 갤러리 — 최종 프로젝트 상세 항목 추가 (2026-07-24)
-- Supabase 대시보드 → SQL Editor 에 전체 붙여넣고 Run 하세요.
--
-- 추가 항목 (모두 nullable — 기존 게시물·다른 일차 게시물에는 영향 없음):
--   project_topic    프로젝트 주제
--   data_used        사용한 데이터
--   data_source_url  데이터 출처(링크)
--   project_intro    프로젝트에 대한 소개
--
-- RLS 정책은 바꾸지 않습니다 (조회·등록만 허용, 수정·삭제 차단 그대로).
-- ============================================================

alter table public.apps
  add column if not exists project_topic   text check (project_topic   is null or char_length(project_topic)   between 1 and 60),
  add column if not exists data_used       text check (data_used       is null or char_length(data_used)       between 1 and 120),
  add column if not exists data_source_url text check (data_source_url is null or (data_source_url ~ '^https://' and char_length(data_source_url) <= 300)),
  add column if not exists project_intro   text check (project_intro   is null or char_length(project_intro)   between 1 and 300);

-- ---------- 적용 확인 ----------
-- select column_name, data_type, is_nullable
--   from information_schema.columns
--  where table_schema = 'public' and table_name = 'apps'
--  order by ordinal_position;
