// 일차별 순차 공개 — release.js의 RELEASED_DAY 기준으로
// ① 목차 카드 잠그기 ② 진행 지도 미래 행 숨기기 ③ 아직 안 열린 일차 페이지 접근 차단
(function () {
  function apply() {
    var released = (typeof window.RELEASED_DAY === 'number') ? window.RELEASED_DAY : 1;

    // ── 강사 미리보기 모드 ──────────────────────────
    // 켜기: 아무 수강생용 페이지나 ?preview=teacher 붙여 접속 (이 브라우저에 기억됨)
    // 끄기: ?preview=off — 수강생과 같은 화면으로 복귀 (수업 화면 공유 전 권장)
    try {
      var q = new URLSearchParams(location.search).get('preview');
      if (q === 'teacher') localStorage.setItem('previewAll', '1');
      if (q === 'off') localStorage.removeItem('previewAll');
    } catch (e) {}
    var preview = false;
    try { preview = localStorage.getItem('previewAll') === '1'; } catch (e) {}
    if (preview) {
      released = 99; // 전 일차 열람
      var bar = document.querySelector('.topbar .inner');
      if (bar) {
        var pb = document.createElement('span');
        pb.className = 'badge';
        pb.textContent = '👁 미리보기';
        pb.style.opacity = '.65';
        bar.appendChild(pb);
      }
    }
    var homeworkDay = (typeof window.HOMEWORK_DAY === 'number') ? window.HOMEWORK_DAY : 1;
    var file = location.pathname.split('/').pop() || 'index.html';

    function dayOf(name) {
      var m = name.match(/^day([1-5])\.html$/);
      if (m) return +m[1];
      if (name === 'homework.html') return homeworkDay;
      if (name === 'extra.html') return 5; // 심화 자료 = 5일차와 함께 공개
      return 0; // index, prep 등은 항상 공개
    }

    // 숙제 카드의 data-day는 HOMEWORK_DAY와 자동 동기화 (HTML 값과 어긋나도 안전)
    var hw = document.querySelector('.linkcard[href="homework.html"]');
    if (hw) hw.setAttribute('data-day', homeworkDay);

    // ① 목차 카드 잠그기
    document.querySelectorAll('.linkcard[data-day]').forEach(function (c) {
      if (+c.getAttribute('data-day') > released) {
        c.classList.add('locked');
        c.setAttribute('aria-disabled', 'true');
        c.removeAttribute('href');
        var d = c.querySelector('.d');
        if (d) d.textContent = '🔒 곧 공개';
      }
    });

    // ② 진행 지도(daymap) 미래 행 숨기기
    document.querySelectorAll('tr[data-day]').forEach(function (r) {
      if (+r.getAttribute('data-day') > released) r.style.display = 'none';
    });

    // ③ 아직 안 열린 일차 페이지 직접 접근 차단
    var me = dayOf(file);
    if (me > released) {
      document.title = '🔒 아직 공개 전 · 데이터 기반 바이브 코딩 병아리반';
      var main = document.querySelector('main');
      if (main) {
        main.innerHTML =
          '<div style="text-align:center;padding:44px 12px">' +
          '<div style="font-size:2.8rem">🔒</div>' +
          '<h1 style="color:var(--accent)">아직 공개 전이에요</h1>' +
          '<div class="under" style="margin:.6rem auto 1.1rem"></div>' +
          '<p class="lead">이 페이지는 <b>' + me + '일차</b>에 열립니다. 조금만 기다려 주세요.</p>' +
          '<p><a href="index.html">← 목차로 돌아가기</a></p>' +
          '</div>';
      }
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', apply);
  } else {
    apply();
  }
})();
