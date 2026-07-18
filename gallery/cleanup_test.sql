-- ============================================================
-- 병아리반 작품 갤러리 — 테스트 데이터 일괄 삭제
-- Supabase 대시보드 → SQL Editor 에 전체 붙여넣고 Run 하세요.
--
-- 대상: nickname 이 '테스트'로 시작하는 apps 행 전부
--       (feedback 은 apps.id 를 참조하는 FK 에 on delete cascade 가
--        걸려 있어 apps 삭제 시 관련 feedback 도 함께 삭제됩니다.
--        다만 '테스트'로 시작하지 않는 정상 게시물에, 닉네임이
--        '테스트'로 시작하는 피드백만 달린 경우도 있을 수 있어
--        feedback 단독 삭제 구문도 함께 둡니다.)
--
-- 실행 전 몇 건이 지워질지 미리 보고 싶다면 아래 SELECT 문을 먼저
-- 실행해서 확인하세요.
-- ============================================================

-- ---------- (선택) 삭제 전 확인용 SELECT ----------
-- select id, nickname, assignment, likes, created_at
--   from public.apps
--  where nickname like '테스트%'
--  order by created_at;

-- select id, app_id, nickname, content, created_at
--   from public.feedback
--  where nickname like '테스트%'
--  order by created_at;

-- ---------- 1) '테스트'로 시작하는 apps 삭제 ----------
-- (연결된 feedback 은 on delete cascade 로 자동 삭제됩니다)
delete from public.apps
 where nickname like '테스트%';

-- ---------- 2) 혹시 남아있을 수 있는, 닉네임이 '테스트'로 시작하는
--              feedback 단독 삭제 (정상 게시물에 테스트 피드백만 남긴 경우 대비) ----------
delete from public.feedback
 where nickname like '테스트%';

-- ---------- 삭제 후 확인 ----------
-- select count(*) as remaining_test_apps
--   from public.apps
--  where nickname like '테스트%';

-- select count(*) as remaining_test_feedback
--   from public.feedback
--  where nickname like '테스트%';
