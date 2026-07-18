-- 좋아요 위조 방지 (확실판 · 2026-07-18)
-- REVOKE 방식은 테이블 전체 INSERT 권한에 무시되므로, 트리거로 강제한다.
-- insert 시 likes 값을 무엇으로 보내든 항상 0으로 덮어씀. 증가는 increment_likes RPC로만.
create or replace function public.force_likes_zero()
returns trigger language plpgsql as $$
begin
  new.likes := 0;
  return new;
end;
$$;

drop trigger if exists trg_force_likes_zero on public.apps;
create trigger trg_force_likes_zero
  before insert on public.apps
  for each row execute function public.force_likes_zero();
