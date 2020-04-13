# Application code details

## Uploads

Shrine https://shrinerb.com/docs/getting-started

    <form action="/photos" method="post" enctype="multipart/form-data">
      <input name="photo[image]" type="hidden" value="<%= @photo.cached_image_data %>" />
      <input name="photo[image] "type="file" />
      <input type="submit" value="Create" />
    </form>
