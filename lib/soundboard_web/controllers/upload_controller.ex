defmodule SoundboardWeb.UploadController do
  use SoundboardWeb, :controller

  alias Soundboard.UploadsPath

  def show(conn, %{"path" => path}) do
    case UploadsPath.safe_joined_path(path) do
      {:ok, file_path} ->
        if File.regular?(file_path) do
          conn
          |> put_resp_content_type(MIME.from_path(file_path), nil)
          |> send_file(200, file_path)
        else
          send_resp(conn, 404, "File not found")
        end

      :error ->
        send_resp(conn, 404, "File not found")
    end
  end
end
