document.addEventListener("trix-attachment-add", function (event) {
  const attachment = event.attachment;
  if (!attachment.file) return;

  const form = new FormData();
  form.append("file", attachment.file);

  const csrfToken = document.querySelector("meta[name='csrf-token']")?.content;

  const xhr = new XMLHttpRequest();
  xhr.open("POST", "/uploads", true);
  if (csrfToken) xhr.setRequestHeader("X-CSRF-Token", csrfToken);

  xhr.upload.addEventListener("progress", function (event) {
    if (event.lengthComputable) {
      const progress = (event.loaded / event.total) * 100;
      attachment.setUploadProgress(progress);
    }
  });

  xhr.addEventListener("load", function () {
    if (xhr.status === 200) {
      const data = JSON.parse(xhr.responseText);
      attachment.setAttributes({ url: data.url, href: data.url });
    }
  });

  xhr.send(form);
});
