// Close alerts automatically after 5 seconds
document.addEventListener('turbo:load', () => {
  const alerts = document.querySelectorAll('.alert');

  alerts.forEach(alert => {
    const closeButton = alert.querySelector('.btn-close');
    setTimeout(() => {
      if (closeButton) {
        closeButton.click(); //Close programatically
      } else {
        alert.remove(); //Remove if no close button
      }
    }, 5000);
  });
});
zzs
// Close alert when clicking on it
document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.alert').forEach(alert => {
    alert.addEventListener('click', (e) => {
      if (e.target.classList.contains('alert')) {
        const closeButton = alert.querySelector('.btn-close');
        if (closeButton) closeButton.click();
      }
    });
  });
});
