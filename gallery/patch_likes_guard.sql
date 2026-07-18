-- 좋아요 위조 방지 패치 (2026-07-18 강화 테스트 결함 수정)
-- 효과: 익명(publishable 키) insert에서 likes 컬럼 지정 자체를 차단.
--       likes는 default 0으로만 시작하고 증가는 increment_likes RPC로만 가능.
revoke insert (likes) on public.apps from anon;
revoke insert (likes) on public.apps from authenticated;
