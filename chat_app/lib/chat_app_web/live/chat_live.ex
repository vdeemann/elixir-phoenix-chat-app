defmodule ChatAppWeb.ChatLive do
  use ChatAppWeb, :live_view

  def mount(_params, _session, socket) do
    users = [
      %{id: 1, name: "Marcus", avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=32&h=32&fit=crop&crop=face"},
      %{id: 2, name: "Sarah", avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=32&h=32&fit=crop&crop=face"},
      %{id: 3, name: "Alex", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=32&h=32&fit=crop&crop=face"}
    ]

    # Comprehensive emoji collection organized by categories
    emoji_categories = %{
      "frequently_used" => ["😊", "😂", "❤️", "👍", "😭", "😍", "🔥", "😎", "💯", "🎉", "😢", "😅", "🙄", "😘", "💔", "😴", "😋", "🤔", "😡", "🥺", "😉", "🤗", "😌", "🙃", "😏", "🤷", "💕", "✨"],

      "smileys" => ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🤩", "🥳", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "😣", "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡", "🤬", "🤯", "😳", "🥵", "🥶", "😱", "😨", "😰", "😥", "😓", "🤗", "🤔", "🤭", "🤫", "🤥", "😶", "😐", "😑", "😬", "🙄", "😯", "😦", "😧", "😮", "😲", "🥱", "😴", "🤤", "😪", "😵", "🤐", "🥴", "🤢", "🤮", "🤧", "😷", "🤒", "🤕"],

      "people" => ["👋", "🤚", "🖐️", "✋", "🖖", "👌", "🤏", "✌️", "🤞", "🤟", "🤘", "🤙", "👈", "👉", "👆", "🖕", "👇", "☝️", "👍", "👎", "👊", "✊", "🤛", "🤜", "👏", "🙌", "👐", "🤲", "🤝", "🙏", "✍️", "💅", "🤳", "💪", "🦾", "🦿", "🦵", "🦶", "👂", "🦻", "👃", "🧠", "🫀", "🫁", "🦷", "🦴", "👀", "👁️", "👅", "👄", "👶", "🧒", "👦", "👧", "🧑", "👱", "👨", "🧔", "👩", "🧓", "👴", "👵", "🙍", "🙎", "🙅", "🙆", "💁", "🙋", "🧏", "🙇", "🤦", "🤷", "👮", "🕵️", "💂", "🥷", "👷", "🤴", "👸", "👳", "👲", "🧕", "🤵", "👰", "🤰", "🤱", "👼", "🎅", "🤶", "🦸", "🦹", "🧙", "🧚", "🧛", "🧜", "🧝", "🧞", "🧟", "💆", "💇", "🚶", "🧍", "🧎", "🏃", "💃", "🕺", "🧘", "🛀", "🛌", "🕴️", "🗣️", "👤", "👥", "🫂", "👣"],

      "animals" => ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊", "🐒", "🐔", "🐧", "🐦", "🐤", "🐣", "🐥", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌", "🐞", "🐜", "🦟", "🦗", "🕷️", "🦂", "🐢", "🐍", "🦎", "🦖", "🦕", "🐙", "🦑", "🦐", "🦞", "🦀", "🐡", "🐠", "🐟", "🐬", "🐳", "🐋", "🦈", "🐊", "🐅", "🐆", "🦓", "🦍", "🦧", "🐘", "🦛", "🦏", "🐪", "🐫", "🦒", "🦘", "🐃", "🐂", "🐄", "🐎", "🐖", "🐏", "🐑", "🦙", "🐐", "🦌", "🐕", "🐩", "🦮", "🐈", "🐓", "🦃", "🦚", "🦜", "🦢", "🦩", "🕊️", "🐇", "🦝", "🦨", "🦡", "🦦", "🦥", "🐁", "🐀", "🐿️", "🦔"],

      "food" => ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶️", "🫒", "🌽", "🥕", "🫑", "🧄", "🧅", "🥔", "🍠", "🥐", "🥯", "🍞", "🥖", "🥨", "🧀", "🥚", "🍳", "🧈", "🥞", "🧇", "🥓", "🥩", "🍗", "🍖", "🦴", "🌭", "🍔", "🍟", "🍕", "🫓", "🥪", "🥙", "🧆", "🌮", "🌯", "🫔", "🥗", "🥘", "🫕", "🥫", "🍝", "🍜", "🍲", "🍛", "🍣", "🍱", "🥟", "🦪", "🍤", "🍙", "🍚", "🍘", "🍥", "🥠", "🥮", "🍢", "🍡", "🍧", "🍨", "🍦", "🥧", "🧁", "🍰", "🎂", "🍮", "🍭", "🍬", "🍫", "🍿", "🍩", "🍪", "🌰", "🥜", "🍯", "🥛", "🍼", "☕", "🫖", "🍵", "🧃", "🥤", "🍶", "🍺", "🍻", "🥂", "🍷", "🥃", "🍸", "🍹", "🧉", "🍾"],

      "activity" => ["⚽", "🏀", "🏈", "⚾", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳", "🪁", "🏹", "🎣", "🤿", "🥊", "🥋", "🎽", "🛹", "🛼", "🛷", "⛸️", "🥌", "🎿", "⛷️", "🏂", "🪂", "🏋️", "🤼", "🤸", "⛹️", "🤺", "🏇", "🧘", "🏄", "🏊", "🤽", "🚣", "🧗", "🚵", "🚴", "🏆", "🥇", "🥈", "🥉", "🏅", "🎖️", "🏵️", "🎗️", "🎫", "🎟️", "🎪", "🤹", "🎭", "🩰", "🎨", "🎬", "🎤", "🎧", "🎼", "🎵", "🎶"],

      "travel" => ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🏍️", "🛵", "🚲", "🛴", "🛺", "🚨", "🚔", "🚍", "🚘", "🚖", "🚡", "🚠", "🚟", "🚃", "🚋", "🚞", "🚝", "🚄", "🚅", "🚈", "🚂", "🚆", "🚇", "🚊", "🚉", "✈️", "🛫", "🛬", "🛩️", "💺", "🛰️", "🚀", "🛸", "🚁", "🛶", "⛵", "🚤", "🛥️", "🛳️", "⛴️", "🚢", "⚓", "⛽", "🚧", "🚦", "🚥", "🚏", "🗺️", "🗿", "🗽", "🗼", "🏰", "🏯", "🏟️", "🎡", "🎢", "🎠", "⛲", "⛱️", "🏖️", "🏝️", "🏜️", "🌋", "⛰️", "🏔️", "🗻", "🏕️", "⛺", "🏠", "🏡", "🏘️", "🏚️", "🏗️", "🏭", "🏢", "🏬", "🏣", "🏤", "🏥", "🏦", "🏨", "🏪", "🏫", "🏩", "💒", "🏛️", "⛪", "🕌", "🛕", "🕍", "🕋", "⛩️", "🛤️", "🛣️"],

      "objects" => ["⌚", "📱", "📲", "💻", "⌨️", "🖥️", "🖨️", "🖱️", "🖲️", "🕹️", "🗜️", "💽", "💾", "💿", "📀", "📼", "📷", "📸", "📹", "🎥", "📽️", "🎞️", "📞", "☎️", "📟", "📠", "📺", "📻", "🎙️", "🎚️", "🎛️", "🧭", "⏱️", "⏲️", "⏰", "🕰️", "⌛", "⏳", "📡", "🔋", "🔌", "💡", "🔦", "🕯️", "🪔", "🧯", "🛢️", "💸", "💵", "💴", "💶", "💷", "🪙", "💰", "💳", "💎", "⚖️", "🪜", "🧰", "🔧", "🔨", "⚒️", "🛠️", "⛏️", "🔩", "⚙️", "🪤", "🧱", "⛓️", "🧲", "🔫", "💣", "🧨", "🪓", "🔪", "🗡️", "⚔️", "🛡️", "🚬", "⚰️", "🪦", "⚱️", "🏺", "🔮", "📿", "🧿", "💈", "⚗️", "🔭", "🔬", "🕳️", "🩹", "🩺", "💊", "💉", "🩸", "🧬", "🦠", "🧫", "🧪", "🌡️", "🧹", "🧺", "🧻", "🚽", "🚰", "🚿", "🛁", "🧼", "🪥", "🪒", "🧴", "🛎️", "🔑", "🗝️", "🚪", "🪑", "🛋️", "🛏️", "🧸", "🖼️", "🛍️", "🛒", "🎁", "🎈", "🎏", "🎀", "🎊", "🎉", "🎎", "🏮", "🎐", "🧧"],

      "symbols" => ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❣️", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "💟", "☮️", "✝️", "☪️", "🕉️", "☸️", "✡️", "🔯", "🕎", "☯️", "☦️", "🛐", "⛎", "♈", "♉", "♊", "♋", "♌", "♍", "♎", "♏", "♐", "♑", "♒", "♓", "🆔", "⚛️", "🉑", "☢️", "☣️", "📴", "📳", "🈶", "🈚", "🈸", "🈺", "🈷️", "✴️", "🆚", "💮", "🉐", "㊙️", "㊗️", "🈴", "🈵", "🈹", "🈲", "🅰️", "🅱️", "🆎", "🆑", "🅾️", "🆘", "❌", "⭕", "🛑", "⛔", "📛", "🚫", "💯", "💢", "♨️", "🚷", "🚯", "🚳", "🚱", "🔞", "📵", "🚭", "❗", "❕", "❓", "❔", "‼️", "⁉️", "🔅", "🔆", "〽️", "⚠️", "🚸", "🔱", "⚜️", "🔰", "♻️", "✅", "🈯", "💹", "❇️", "✳️", "❎", "🌐", "💠", "Ⓜ️", "🌀", "💤", "🏧", "🚾", "♿", "🅿️", "🈳", "🈂️", "🛂", "🛃", "🛄", "🛅", "🚹", "🚺", "🚼", "🚻", "🚮", "🎦", "📶", "🈁", "🔣", "ℹ️", "🔤", "🔡", "🔠", "🆖", "🆗", "🆙", "🆒", "🆕", "🆓", "0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣", "🔟"],

      "flags" => ["🏁", "🚩", "🎌", "🏴", "🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🇺🇸", "🇬🇧", "🇨🇦", "🇫🇷", "🇩🇪", "🇮🇹", "🇪🇸", "🇯🇵", "🇰🇷", "🇨🇳", "🇮🇳", "🇧🇷", "🇷🇺", "🇦🇺", "🇲🇽", "🇳🇱", "🇸🇪", "🇳🇴", "🇩🇰", "🇫🇮", "🇵🇱", "🇧🇪", "🇨🇭", "🇦🇹", "🇮🇪", "🇵🇹", "🇬🇷", "🇹🇷", "🇮🇱", "🇸🇦", "🇦🇪", "🇪🇬", "🇿🇦", "🇳🇬", "🇰🇪", "🇦🇷", "🇨🇱", "🇨🇴", "🇵🇪", "🇻🇪", "🇹🇭", "🇻🇳", "🇮🇩", "🇲🇾", "🇸🇬", "🇵🇭", "🇳🇿", "🇺🇦", "🇨🇿", "🇭🇺", "🇷🇴", "🇧🇬", "🇭🇷", "🇸🇰", "🇸🇮", "🇪🇪", "🇱🇻", "🇱🇹"]
    }

    {:ok,
     socket
     |> assign(:chat_open, false)
     |> assign(:messages, [])
     |> assign(:message_input, "")
     |> assign(:users, users)
     |> assign(:selected_user, nil)
     |> assign(:emoji_picker_open, false)
     |> assign(:emoji_categories, emoji_categories)
     |> assign(:selected_emoji_category, "frequently_used")
     |> assign(:emoji_search, "")
     |> assign(:gif_picker_open, false)
     |> assign(:gif_search, "")
     |> assign(:gif_results, [])
     |> assign(:trending_gifs, [])
     |> assign(:replying_to, nil)  # Add reply state
     |> assign(:default_skin_tone, "")  # Default skin tone (empty = yellow/default)
     |> assign(:show_skin_tone_picker, false)}  # Show skin tone selector
  end

  def handle_event("set_default_skin_tone", %{"skin_tone" => skin_tone}, socket) do
    {:noreply,
     socket
     |> assign(:default_skin_tone, skin_tone)
     |> assign(:show_skin_tone_picker, false)}
  end

  def handle_event("toggle_skin_tone_picker", _params, socket) do
    {:noreply, assign(socket, :show_skin_tone_picker, !socket.assigns.show_skin_tone_picker)}
  end

  def handle_event("reply_to_message", %{"message_id" => message_id}, socket) do
    message_id = String.to_integer(message_id)
    replying_to = Enum.find(socket.assigns.messages, &(&1.id == message_id))

    {:noreply,
     socket
     |> assign(:replying_to, replying_to)
     |> assign(:emoji_picker_open, false)
     |> assign(:gif_picker_open, false)}
  end

  def handle_event("cancel_reply", _params, socket) do
    {:noreply, assign(socket, :replying_to, nil)}
  end

  def handle_event("select_emoji_category", %{"category" => category}, socket) do
    {:noreply, assign(socket, :selected_emoji_category, category)}
  end

  def handle_event("search_emoji", %{"search" => search}, socket) do
    {:noreply, assign(socket, :emoji_search, search)}
  end

  def handle_event("toggle_emoji_picker", _params, socket) do
    {:noreply,
     socket
     |> assign(:emoji_picker_open, !socket.assigns.emoji_picker_open)
     |> assign(:gif_picker_open, false)}  # Close GIF picker when opening emoji picker
  end

  def handle_event("toggle_gif_picker", _params, socket) do
    socket = if !socket.assigns.gif_picker_open and socket.assigns.trending_gifs == [] do
      # Load trending GIFs when opening for the first time
      case fetch_trending_gifs() do
        {:ok, gifs} -> assign(socket, :trending_gifs, gifs)
        {:error, _} -> socket
      end
    else
      socket
    end

    {:noreply,
     socket
     |> assign(:gif_picker_open, !socket.assigns.gif_picker_open)
     |> assign(:emoji_picker_open, false)}  # Close emoji picker when opening GIF picker
  end

  def handle_event("search_gif", %{"search" => search}, socket) do
    socket = if String.trim(search) != "" do
      case search_gifs(search) do
        {:ok, gifs} -> assign(socket, :gif_results, gifs)
        {:error, _} -> assign(socket, :gif_results, [])
      end
    else
      assign(socket, :gif_results, [])
    end

    {:noreply, assign(socket, :gif_search, search)}
  end

  def handle_event("select_gif", %{"gif_url" => gif_url}, socket) do
    if String.trim(gif_url) != "" do
      user_message = %{
        id: :rand.uniform(10000),
        text: "",
        gif_url: gif_url,
        sender: :user,
        time: DateTime.utc_now(),
        reply_to: socket.assigns.replying_to  # Include reply context
      }

      # Generate response based on selected user
      response_text = case socket.assigns.selected_user do
        %{name: "Marcus"} -> "Nice GIF! Marcus here. 😄"
        %{name: "Sarah"} -> "Haha, love it! Sarah responding. 😊"
        %{name: "Alex"} -> "That's awesome! Alex here. 👍"
        _ -> "Great GIF! Thanks for sharing."
      end

      bot_message = %{
        id: :rand.uniform(10000),
        text: response_text,
        sender: :bot,
        time: DateTime.add(DateTime.utc_now(), 1, :second)
      }

      {:noreply,
       socket
       |> assign(:messages, socket.assigns.messages ++ [user_message, bot_message])
       |> assign(:gif_picker_open, false)
       |> assign(:replying_to, nil)}  # Clear reply state
    else
      {:noreply, socket}
    end
  end

  def handle_event("select_emoji", %{"emoji" => emoji}, socket) do
    current_message = socket.assigns.message_input
    # Apply default skin tone if applicable
    emoji_with_skin_tone = apply_default_skin_tone(emoji, socket.assigns.default_skin_tone)
    new_message = current_message <> emoji_with_skin_tone

    {:noreply,
     socket
     |> assign(:message_input, new_message)}
     # Removed |> assign(:emoji_picker_open, false) to keep picker open
  end

  def handle_event("toggle_chat", _params, socket) do
    {:noreply, assign(socket, :chat_open, !socket.assigns.chat_open)}
  end

  def handle_event("select_user", %{"user_id" => user_id}, socket) do
    user_id = String.to_integer(user_id)
    selected_user = Enum.find(socket.assigns.users, &(&1.id == user_id))

    {:noreply,
     socket
     |> assign(:selected_user, selected_user)
     |> assign(:messages, [])  # Clear messages when switching users
     |> assign(:replying_to, nil)}  # Clear reply state when switching users
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    if String.trim(message) != "" do
      user_message = %{
        id: :rand.uniform(10000),
        text: message,
        sender: :user,
        time: DateTime.utc_now(),
        reply_to: socket.assigns.replying_to  # Include reply context
      }

      # Generate response based on selected user
      response_text = case socket.assigns.selected_user do
        %{name: "Marcus"} -> "Hey! Marcus here. Thanks for your message!"
        %{name: "Sarah"} -> "Hi there! Sarah responding. How can I help?"
        %{name: "Alex"} -> "Hello! Alex here. What's on your mind?"
        _ -> "Thanks for reaching out! We'll get back to you soon."
      end

      bot_message = %{
        id: :rand.uniform(10000),
        text: response_text,
        sender: :bot,
        time: DateTime.add(DateTime.utc_now(), 1, :second)
      }

      {:noreply,
       socket
       |> assign(:messages, socket.assigns.messages ++ [user_message, bot_message])
       |> assign(:message_input, "")
       |> assign(:replying_to, nil)}  # Clear reply state after sending
    else
      {:noreply, socket}
    end
  end

  def handle_event("update_message", %{"message" => message}, socket) do
    {:noreply, assign(socket, :message_input, message)}
  end

  # Helper function to filter emojis based on search
  defp filter_emojis(emoji_categories, search_term) do
    search_term = String.downcase(search_term)

    emoji_categories
    |> Map.values()
    |> List.flatten()
    |> Enum.filter(fn emoji ->
      # Simple emoji search - you could enhance this with emoji names/keywords
      emoji_names = %{
        "😊" => "smile happy joy",
        "❤️" => "heart love red",
        "👍" => "thumbs up like good yes",
        "😂" => "laugh crying funny lol",
        "🔥" => "fire hot flame lit",
        "💯" => "hundred perfect score",
        "😎" => "cool sunglasses awesome",
        "🎉" => "party celebrate confetti",
        "😢" => "cry sad tear",
        "😅" => "sweat laugh nervous",
        "🙄" => "eye roll annoyed",
        "😘" => "kiss love wink",
        "💔" => "broken heart sad",
        "😴" => "sleep tired sleepy",
        "😋" => "yum delicious tongue",
        "🤔" => "think thinking hmm",
        "😡" => "angry mad rage",
        "🥺" => "pleading puppy eyes",
        "😉" => "wink flirt",
        "🤗" => "hug embrace",
        "😌" => "calm peaceful relieved",
        "🙃" => "upside down silly",
        "😏" => "smirk sly",
        "🤷" => "shrug dunno idk",
        "💕" => "hearts love pink",
        "✨" => "sparkle magic stars"
      }

      emoji_name = Map.get(emoji_names, emoji, "")
      String.contains?(emoji_name, search_term)
    end)
    |> Enum.take(50) # Limit search results
  end

  # Helper function to get skin tone variations for emoji
  defp get_skin_tone_variations(emoji) do
    skin_tones = ["🏻", "🏼", "🏽", "🏾", "🏿"]

    # Base emojis that support skin tones
    skin_tone_emojis = [
      "👋", "🤚", "🖐️", "✋", "🖖", "👌", "🤏", "✌️", "🤞", "🤟", "🤘", "🤙",
      "👈", "👉", "👆", "🖕", "👇", "☝️", "👍", "👎", "👊", "✊", "🤛", "🤜",
      "👏", "🙌", "👐", "🤲", "🙏", "✍️", "💅", "🤳", "💪", "🦵", "🦶", "👂",
      "👃", "👶", "🧒", "👦", "👧", "🧑", "👱", "👨", "🧔", "👩", "🧓", "👴",
      "👵", "🙍", "🙎", "🙅", "🙆", "💁", "🙋", "🧏", "🙇", "🤦", "🤷", "👮",
      "🕵️", "💂", "👷", "🤴", "👸", "👳", "👲", "🧕", "🤵", "👰", "🤰", "🤱",
      "🎅", "🤶", "🦸", "🦹", "🧙", "🧚", "🧛", "🧜", "🧝", "💆", "💇", "🚶",
      "🧍", "🧎", "🏃", "💃", "🕺", "🧘", "🛀", "🛌", "🕴️"
    ]

    # Remove any existing skin tone modifiers to get base emoji
    base_emoji = String.replace(emoji, ["🏻", "🏼", "🏽", "🏾", "🏿"], "")

    if Enum.member?(skin_tone_emojis, base_emoji) do
      [base_emoji | Enum.map(skin_tones, fn tone -> base_emoji <> tone end)]
    else
      [emoji]
    end
  end

  # Helper function to apply default skin tone to emoji
  defp apply_default_skin_tone(emoji, default_skin_tone) do
    if default_skin_tone != "" do
      # Check if emoji supports skin tones by checking if it's in our list
      skin_tone_emojis = [
        "👋", "🤚", "🖐️", "✋", "🖖", "👌", "🤏", "✌️", "🤞", "🤟", "🤘", "🤙",
        "👈", "👉", "👆", "🖕", "👇", "☝️", "👍", "👎", "👊", "✊", "🤛", "🤜",
        "👏", "🙌", "👐", "🤲", "🙏", "✍️", "💅", "🤳", "💪", "🦵", "🦶", "👂",
        "👃", "👶", "🧒", "👦", "👧", "🧑", "👱", "👨", "🧔", "👩", "🧓", "👴",
        "👵", "🙍", "🙎", "🙅", "🙆", "💁", "🙋", "🧏", "🙇", "🤦", "🤷", "👮",
        "🕵️", "💂", "👷", "🤴", "👸", "👳", "👲", "🧕", "🤵", "👰", "🤰", "🤱",
        "🎅", "🤶", "🦸", "🦹", "🧙", "🧚", "🧛", "🧜", "🧝", "💆", "💇", "🚶",
        "🧍", "🧎", "🏃", "💃", "🕺", "🧘", "🛀", "🛌", "🕴️"
      ]

      # Remove any existing skin tone modifiers first
      base_emoji = String.replace(emoji, ["🏻", "🏼", "🏽", "🏾", "🏿"], "")

      if Enum.member?(skin_tone_emojis, base_emoji) do
        base_emoji <> default_skin_tone
      else
        emoji
      end
    else
      emoji
    end
  end

  # Helper function to truncate text for reply preview
  defp truncate_text(text, length \\ 50) do
    if String.length(text) > length do
      String.slice(text, 0, length) <> "..."
    else
      text
    end
  end

  # Tenor API functions - Using mock data with working GIPHY URLs
  # To use real Tenor API, add {:httpoison, "~> 2.0"} and {:jason, "~> 1.4"} to mix.exs
  defp fetch_trending_gifs() do
    # Mock trending GIFs with working GIPHY URLs
    mock_gifs = [
      %{
        id: "1",
        title: "Happy Dance",
        gif_url: "https://media.giphy.com/media/3o7btPCcdNniyf0ArS/giphy.gif",
        preview_url: "https://media.giphy.com/media/3o7btPCcdNniyf0ArS/200.gif"
      },
      %{
        id: "2",
        title: "Thumbs Up",
        gif_url: "https://media.giphy.com/media/111ebonMs90YLu/giphy.gif",
        preview_url: "https://media.giphy.com/media/111ebonMs90YLu/200.gif"
      },
      %{
        id: "3",
        title: "Celebration",
        gif_url: "https://media.giphy.com/media/g9582DNuQppxC/giphy.gif",
        preview_url: "https://media.giphy.com/media/g9582DNuQppxC/200.gif"
      },
      %{
        id: "4",
        title: "Laughing",
        gif_url: "https://media.giphy.com/media/10JhviFuU2gWD6/giphy.gif",
        preview_url: "https://media.giphy.com/media/10JhviFuU2gWD6/200.gif"
      },
      %{
        id: "5",
        title: "High Five",
        gif_url: "https://media.giphy.com/media/3KC2jD2QcBOSc/giphy.gif",
        preview_url: "https://media.giphy.com/media/3KC2jD2QcBOSc/200.gif"
      },
      %{
        id: "6",
        title: "Clapping",
        gif_url: "https://media.giphy.com/media/7rj2ZgttvgomY/giphy.gif",
        preview_url: "https://media.giphy.com/media/7rj2ZgttvgomY/200.gif"
      },
      %{
        id: "7",
        title: "Yes",
        gif_url: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/giphy.gif",
        preview_url: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/200.gif"
      },
      %{
        id: "8",
        title: "Love",
        gif_url: "https://media.giphy.com/media/3o6Mb8Jmb7tnYYOiqY/giphy.gif",
        preview_url: "https://media.giphy.com/media/3o6Mb8Jmb7tnYYOiqY/200.gif"
      }
    ]
    {:ok, mock_gifs}
  end

  defp search_gifs(query) do
    # Mock search results based on query with working GIPHY URLs
    all_gifs = %{
      "happy" => [
        %{id: "h1", title: "Happy Dance", gif_url: "https://media.giphy.com/media/3o7btPCcdNniyf0ArS/giphy.gif", preview_url: "https://media.giphy.com/media/3o7btPCcdNniyf0ArS/200.gif"},
        %{id: "h2", title: "Smile", gif_url: "https://media.giphy.com/media/yoJC2El7xJkYCadlWE/giphy.gif", preview_url: "https://media.giphy.com/media/yoJC2El7xJkYCadlWE/200.gif"},
        %{id: "h3", title: "Joy", gif_url: "https://media.giphy.com/media/3o6Mb8Jmb7tnYYOiqY/giphy.gif", preview_url: "https://media.giphy.com/media/3o6Mb8Jmb7tnYYOiqY/200.gif"}
      ],
      "laugh" => [
        %{id: "l1", title: "Laughing", gif_url: "https://media.giphy.com/media/10JhviFuU2gWD6/giphy.gif", preview_url: "https://media.giphy.com/media/10JhviFuU2gWD6/200.gif"},
        %{id: "l2", title: "LOL", gif_url: "https://media.giphy.com/media/3o7btNhMBytxAM6YBa/giphy.gif", preview_url: "https://media.giphy.com/media/3o7btNhMBytxAM6YBa/200.gif"},
        %{id: "l3", title: "Funny", gif_url: "https://media.giphy.com/media/kj8RVuDxh4x7W/giphy.gif", preview_url: "https://media.giphy.com/media/kj8RVuDxh4x7W/200.gif"}
      ],
      "celebrate" => [
        %{id: "c1", title: "Party", gif_url: "https://media.giphy.com/media/g9582DNuQppxC/giphy.gif", preview_url: "https://media.giphy.com/media/g9582DNuQppxC/200.gif"},
        %{id: "c2", title: "Clapping", gif_url: "https://media.giphy.com/media/7rj2ZgttvgomY/giphy.gif", preview_url: "https://media.giphy.com/media/7rj2ZgttvgomY/200.gif"},
        %{id: "c3", title: "Woohoo", gif_url: "https://media.giphy.com/media/26u4lOMA8JKSnL9Uk/giphy.gif", preview_url: "https://media.giphy.com/media/26u4lOMA8JKSnL9Uk/200.gif"}
      ],
      "thumbs" => [
        %{id: "t1", title: "Thumbs Up", gif_url: "https://media.giphy.com/media/111ebonMs90YLu/giphy.gif", preview_url: "https://media.giphy.com/media/111ebonMs90YLu/200.gif"},
        %{id: "t2", title: "Good Job", gif_url: "https://media.giphy.com/media/3KC2jD2QcBOSc/giphy.gif", preview_url: "https://media.giphy.com/media/3KC2jD2QcBOSc/200.gif"},
        %{id: "t3", title: "Approval", gif_url: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/giphy.gif", preview_url: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/200.gif"}
      ],
      "love" => [
        %{id: "v1", title: "Heart Eyes", gif_url: "https://media.giphy.com/media/3o6Mb8Jmb7tnYYOiqY/giphy.gif", preview_url: "https://media.giphy.com/media/3o6Mb8Jmb7tnYYOiqY/200.gif"},
        %{id: "v2", title: "Love", gif_url: "https://media.giphy.com/media/26BRBKqUiq586bRVm/giphy.gif", preview_url: "https://media.giphy.com/media/26BRBKqUiq586bRVm/200.gif"},
        %{id: "v3", title: "Kiss", gif_url: "https://media.giphy.com/media/11sBLVxNs7v6WA/giphy.gif", preview_url: "https://media.giphy.com/media/11sBLVxNs7v6WA/200.gif"}
      ],
      "yes" => [
        %{id: "y1", title: "Yes", gif_url: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/giphy.gif", preview_url: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/200.gif"},
        %{id: "y2", title: "Nodding", gif_url: "https://media.giphy.com/media/3ornjPrVfRT0Nze3o4/giphy.gif", preview_url: "https://media.giphy.com/media/3ornjPrVfRT0Nze3o4/200.gif"}
      ],
      "no" => [
        %{id: "n1", title: "No", gif_url: "https://media.giphy.com/media/1zSz5MVw4zKg0/giphy.gif", preview_url: "https://media.giphy.com/media/1zSz5MVw4zKg0/200.gif"},
        %{id: "n2", title: "Nope", gif_url: "https://media.giphy.com/media/6Q2KA5ly49368/giphy.gif", preview_url: "https://media.giphy.com/media/6Q2KA5ly49368/200.gif"}
      ]
    }

    # Simple search logic - match query to available categories
    search_key = String.downcase(query)
    results = Enum.find_value(all_gifs, [], fn {key, gifs} ->
      if String.contains?(search_key, key) or String.contains?(key, search_key) do
        gifs
      end
    end)

    if results == [], do: {:ok, []}, else: {:ok, results}
  end

  # To enable real Tenor API:
  # 1. Add to mix.exs: {:httpoison, "~> 2.0"}, {:jason, "~> 1.4"}
  # 2. Get API key from: https://developers.google.com/tenor/guides/quickstart
  # 3. Replace the functions above with:
  #
  # defp fetch_trending_gifs() do
  #   api_key = System.get_env("TENOR_API_KEY") || "YOUR_API_KEY"
  #   url = "https://tenor.googleapis.com/v2/featured?key=#{api_key}&limit=20&media_filter=gif"
  #
  #   case HTTPoison.get(url) do
  #     {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  #       case Jason.decode(body) do
  #         {:ok, %{"results" => results}} ->
  #           gifs = Enum.map(results, fn gif ->
  #             %{
  #               id: gif["id"],
  #               title: gif["title"] || "GIF",
  #               gif_url: get_in(gif, ["media_formats", "gif", "url"]) || "",
  #               preview_url: get_in(gif, ["media_formats", "tinygif", "url"]) || get_in(gif, ["media_formats", "gif", "url"]) || ""
  #             }
  #           end)
  #           {:ok, gifs}
  #         _ -> {:error, "Failed to parse response"}
  #       end
  #     _ -> {:error, "Failed to fetch trending GIFs"}
  #   end
  # end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-white relative">
      <!-- Floating Chat Widget -->
      <div class="fixed bottom-6 right-6 z-50 flex flex-col items-end space-y-4">
        <!-- Chat Window (when open) -->
        <div class={"#{if @chat_open, do: "block animate-fade-in", else: "hidden"}"}>
          <div class="bg-white rounded-xl shadow-2xl border w-[450px] h-[calc(100vh-8rem)] flex flex-col">
            <!-- User Selection Area -->
            <div class="p-5 bg-white rounded-t-xl">
              <div class="flex items-center space-x-2">
                <!-- User Avatars -->
                <div class="flex space-x-2">
                  <%= for user <- @users do %>
                    <button
                      phx-click="select_user"
                      phx-value-user_id={user.id}
                      class={"w-8 h-8 rounded-full border-2 transition-all duration-200 hover:scale-110 #{if @selected_user && @selected_user.id == user.id, do: "border-emerald-500 ring-2 ring-emerald-200", else: "border-gray-300 hover:border-emerald-300"}"}
                    >
                      <img class="w-full h-full rounded-full object-cover" src={user.avatar} alt={user.name} />
                    </button>
                  <% end %>
                </div>

                <!-- Selected User Name -->
                <%= if @selected_user do %>
                  <div class="ml-2">
                    <p class="text-sm font-medium text-gray-900"><%= @selected_user.name %></p>
                    <p class="text-xs text-gray-500">Online now</p>
                  </div>
                <% else %>
                  <div class="ml-2">
                    <p class="text-sm font-medium text-gray-900">Select a contact</p>
                    <p class="text-xs text-gray-500">Choose someone to chat</p>
                  </div>
                <% end %>
              </div>
            </div>

            <!-- Messages Area -->
            <div class="flex-1 p-5 overflow-y-auto space-y-4 bg-white">
              <!-- Dynamic Messages -->
              <%= for message <- @messages do %>
                <%= if message.sender == :user do %>
                  <!-- User Message -->
                  <div class="flex justify-end animate-slide-in">
                    <div class="bg-emerald-500 text-white rounded-lg p-3 max-w-xs shadow-sm">
                      <!-- Reply Context (if replying) -->
                      <%= if Map.get(message, :reply_to) do %>
                        <div class="bg-emerald-400 bg-opacity-50 rounded p-2 mb-2 text-xs">
                          <div class="flex items-center space-x-1 mb-1">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h10a8 8 0 018 8v2M3 10l6 6m-6-6l6-6" />
                            </svg>
                            <span class="opacity-80">Replying to</span>
                          </div>
                          <%= if Map.get(message.reply_to, :gif_url) do %>
                            <div class="italic opacity-80">GIF message</div>
                          <% else %>
                            <div class="italic opacity-80"><%= truncate_text(message.reply_to.text) %></div>
                          <% end %>
                        </div>
                      <% end %>

                      <%= if Map.get(message, :gif_url) do %>
                        <img src={message.gif_url} alt="GIF" class="rounded max-w-full h-auto" style="max-height: 200px;" />
                      <% else %>
                        <p class="text-sm whitespace-pre-wrap"><%= message.text %></p>
                      <% end %>
                    </div>
                  </div>
                <% else %>
                  <!-- Bot Message with Reply Button -->
                  <div class="flex items-start space-x-3 animate-slide-in group relative">
                    <div class="w-8 h-8 bg-emerald-100 rounded-full flex items-center justify-center flex-shrink-0">
                      <span class="text-emerald-600 text-xs font-semibold">S</span>
                    </div>
                    <div class="flex-1 min-w-0 relative">
                      <div class="bg-white rounded-lg p-3 max-w-xs shadow-sm relative">
                        <%= if Map.get(message, :gif_url) do %>
                          <img src={message.gif_url} alt="GIF" class="rounded max-w-full h-auto" style="max-height: 200px;" />
                        <% else %>
                          <p class="text-sm text-gray-800 whitespace-pre-wrap"><%= message.text %></p>
                        <% end %>

                        <!-- Reply Button (positioned middle-right of message bubble) -->
                        <button
                          phx-click="reply_to_message"
                          phx-value-message_id={message.id}
                          class="absolute top-1/2 -right-2 transform -translate-y-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-200 bg-gray-100 hover:bg-gray-200 rounded-full p-1 text-gray-600 hover:text-gray-800 shadow-sm"
                          title="Reply to this message"
                        >
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h10a8 8 0 018 8v2M3 10l6 6m-6-6l6-6" />
                          </svg>
                        </button>
                      </div>
                    </div>
                  </div>
                <% end %>
              <% end %>
            </div>

            <!-- Message Input Container -->
            <div class="p-5 bg-white rounded-b-xl relative">
              <!-- Reply Preview Bar -->
              <%= if @replying_to do %>
                <div class="mb-3 bg-gray-50 border-l-4 border-emerald-500 p-3 rounded">
                  <div class="flex items-center justify-between">
                    <div class="flex-1">
                      <div class="flex items-center space-x-2 mb-1">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 text-emerald-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h10a8 8 0 018 8v2M3 10l6 6m-6-6l6-6" />
                        </svg>
                        <span class="text-xs font-medium text-emerald-600">Replying to message</span>
                      </div>
                      <%= if Map.get(@replying_to, :gif_url) do %>
                        <p class="text-xs text-gray-600 italic">GIF message</p>
                      <% else %>
                        <p class="text-xs text-gray-600"><%= truncate_text(@replying_to.text) %></p>
                      <% end %>
                    </div>
                    <button
                      phx-click="cancel_reply"
                      class="text-gray-400 hover:text-gray-600 transition-colors ml-2"
                      title="Cancel reply"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  </div>
                </div>
              <% end %>

              <!-- GIF Picker Popup -->
              <%= if @gif_picker_open do %>
                <div class="absolute bottom-full left-0 mb-2 bg-white border border-gray-200 rounded-lg shadow-xl w-full z-50">
                  <!-- Search Bar -->
                  <div class="p-3 border-b border-gray-100">
                    <input
                      type="text"
                      value={@gif_search}
                      phx-change="search_gif"
                      placeholder="Search GIFs..."
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500"
                    />
                  </div>

                  <!-- GIF Grid -->
                  <div class="p-3 max-h-64 overflow-y-auto">
                    <%= if @gif_search != "" and @gif_results != [] do %>
                      <!-- Search Results -->
                      <p class="text-xs text-gray-500 font-medium mb-3 uppercase tracking-wide">
                        Search Results
                      </p>
                      <div class="grid grid-cols-2 gap-2">
                        <%= for gif <- @gif_results do %>
                          <button
                            type="button"
                            phx-click="select_gif"
                            phx-value-gif_url={gif.gif_url}
                            class="relative group overflow-hidden rounded-lg hover:ring-2 hover:ring-emerald-500 transition-all duration-200"
                            title={gif.title}
                          >
                            <img
                              src={gif.preview_url}
                              alt={gif.title}
                              class="w-full h-20 object-cover group-hover:scale-105 transition-transform duration-200"
                              loading="lazy"
                            />
                            <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-10 transition-all duration-200"></div>
                          </button>
                        <% end %>
                      </div>
                    <% else %>
                      <!-- Trending GIFs -->
                      <p class="text-xs text-gray-500 font-medium mb-3 uppercase tracking-wide">
                        <%= if @gif_search != "", do: "No results found", else: "Trending" %>
                      </p>
                      <%= if @trending_gifs != [] do %>
                        <div class="grid grid-cols-2 gap-2">
                          <%= for gif <- @trending_gifs do %>
                            <button
                              type="button"
                              phx-click="select_gif"
                              phx-value-gif_url={gif.gif_url}
                              class="relative group overflow-hidden rounded-lg hover:ring-2 hover:ring-emerald-500 transition-all duration-200"
                              title={gif.title}
                            >
                              <img
                                src={gif.preview_url}
                                alt={gif.title}
                                class="w-full h-20 object-cover group-hover:scale-105 transition-transform duration-200"
                                loading="lazy"
                              />
                              <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-10 transition-all duration-200"></div>
                            </button>
                          <% end %>
                        </div>
                      <% else %>
                        <div class="text-center py-8">
                          <p class="text-gray-500 text-sm">Loading GIFs...</p>
                        </div>
                      <% end %>
                    <% end %>
                  </div>
                </div>
              <% end %>

              <!-- Emoji Picker Popup - Now positioned relative to the input container -->
              <%= if @emoji_picker_open do %>
                <div class="emoji-picker-container absolute bottom-full left-0 mb-2 bg-white border border-gray-200 rounded-lg shadow-xl w-full z-50">
                  <!-- Header with skin tone selector and close button -->
                  <div class="flex items-center justify-between p-3 border-b border-gray-100">
                    <div class="flex items-center space-x-2">
                      <span class="text-sm font-medium text-gray-700">Emojis</span>

                      <!-- Skin Tone Selector -->
                      <div class="relative">
                        <button
                          type="button"
                          phx-click="toggle_skin_tone_picker"
                          class="flex items-center space-x-1 px-2 py-1 bg-gray-100 hover:bg-gray-200 rounded text-sm transition-colors"
                          title="Select default skin tone"
                        >
                          <span class="text-base">
                            <%= case @default_skin_tone do %>
                              <% "🏻" -> %> 👋🏻
                              <% "🏼" -> %> 👋🏼
                              <% "🏽" -> %> 👋🏽
                              <% "🏾" -> %> 👋🏾
                              <% "🏿" -> %> 👋🏿
                              <% _ -> %> 👋
                            <% end %>
                          </span>
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                          </svg>
                        </button>

                        <!-- Skin Tone Dropdown -->
                        <%= if @show_skin_tone_picker do %>
                          <div class="absolute top-full left-0 mt-1 bg-white border border-gray-200 rounded-lg shadow-lg z-60 min-w-max">
                            <div class="p-2 grid grid-cols-6 gap-1">
                              <!-- Default (yellow) -->
                              <button
                                type="button"
                                phx-click="set_default_skin_tone"
                                phx-value-skin_tone=""
                                class={"w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded transition-colors #{if @default_skin_tone == "", do: "bg-blue-100 ring-2 ring-blue-500"}"}
                                title="Default"
                              >
                                👋
                              </button>
                              <!-- Light skin tone -->
                              <button
                                type="button"
                                phx-click="set_default_skin_tone"
                                phx-value-skin_tone="🏻"
                                class={"w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded transition-colors #{if @default_skin_tone == "🏻", do: "bg-blue-100 ring-2 ring-blue-500"}"}
                                title="Light skin tone"
                              >
                                👋🏻
                              </button>
                              <!-- Medium-light skin tone -->
                              <button
                                type="button"
                                phx-click="set_default_skin_tone"
                                phx-value-skin_tone="🏼"
                                class={"w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded transition-colors #{if @default_skin_tone == "🏼", do: "bg-blue-100 ring-2 ring-blue-500"}"}
                                title="Medium-light skin tone"
                              >
                                👋🏼
                              </button>
                              <!-- Medium skin tone -->
                              <button
                                type="button"
                                phx-click="set_default_skin_tone"
                                phx-value-skin_tone="🏽"
                                class={"w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded transition-colors #{if @default_skin_tone == "🏽", do: "bg-blue-100 ring-2 ring-blue-500"}"}
                                title="Medium skin tone"
                              >
                                👋🏽
                              </button>
                              <!-- Medium-dark skin tone -->
                              <button
                                type="button"
                                phx-click="set_default_skin_tone"
                                phx-value-skin_tone="🏾"
                                class={"w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded transition-colors #{if @default_skin_tone == "🏾", do: "bg-blue-100 ring-2 ring-blue-500"}"}
                                title="Medium-dark skin tone"
                              >
                                👋🏾
                              </button>
                              <!-- Dark skin tone -->
                              <button
                                type="button"
                                phx-click="set_default_skin_tone"
                                phx-value-skin_tone="🏿"
                                class={"w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded transition-colors #{if @default_skin_tone == "🏿", do: "bg-blue-100 ring-2 ring-blue-500"}"}
                                title="Dark skin tone"
                              >
                                👋🏿
                              </button>
                            </div>
                          </div>
                        <% end %>
                      </div>
                    </div>

                    <button
                      type="button"
                      phx-click="toggle_emoji_picker"
                      class="text-gray-400 hover:text-gray-600 transition-colors"
                      title="Close emoji picker"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  </div>

                  <!-- Search Bar -->
                  <div class="p-3 border-b border-gray-100">
                    <input
                      type="text"
                      value={@emoji_search}
                      phx-change="search_emoji"
                      placeholder="Search emoji..."
                      class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500"
                    />
                  </div>

                  <!-- Category Tabs -->
                  <div class="flex overflow-x-auto border-b border-gray-100 px-2 scrollbar-hide">
                    <%= for {category, _emojis} <- @emoji_categories do %>
                      <button
                        type="button"
                        phx-click="select_emoji_category"
                        phx-value-category={category}
                        class={"flex-shrink-0 py-2 px-3 text-xs font-medium text-center capitalize transition-colors #{if @selected_emoji_category == category, do: "text-emerald-600 border-b-2 border-emerald-500", else: "text-gray-500 hover:text-gray-700"}"}
                      >
                        <%= case category do %>
                          <% "frequently_used" -> %> 🕒
                          <% "smileys" -> %> 😊
                          <% "people" -> %> 👋
                          <% "animals" -> %> 🐶
                          <% "food" -> %> 🍎
                          <% "activity" -> %> ⚽
                          <% "travel" -> %> 🚗
                          <% "objects" -> %> 💡
                          <% "symbols" -> %> ❤️
                          <% "flags" -> %> 🏁
                          <% _ -> %> <%= category %>
                        <% end %>
                      </button>
                    <% end %>
                  </div>

                  <!-- Emoji Grid -->
                  <div class="p-3 max-h-64 overflow-y-auto">
                    <%= if @emoji_search != "" do %>
                      <!-- Search Results -->
                      <div class="grid grid-cols-8 gap-1">
                        <%= for emoji <- filter_emojis(@emoji_categories, @emoji_search) do %>
                          <button
                            type="button"
                            phx-click="select_emoji"
                            phx-value-emoji={emoji}
                            class="w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded text-lg transition-colors"
                          >
                            <%= apply_default_skin_tone(emoji, @default_skin_tone) %>
                          </button>
                        <% end %>
                      </div>
                    <% else %>
                      <!-- Category Emojis -->
                      <p class="text-xs text-gray-500 font-medium mb-3 uppercase tracking-wide">
                        <%= String.replace(@selected_emoji_category, "_", " ") %>
                      </p>
                      <div class="grid grid-cols-8 gap-1">
                        <%= for emoji <- Map.get(@emoji_categories, @selected_emoji_category, []) do %>
                          <button
                            type="button"
                            phx-click="select_emoji"
                            phx-value-emoji={emoji}
                            class="w-8 h-8 flex items-center justify-center hover:bg-gray-100 rounded text-lg transition-colors"
                          >
                            <%= apply_default_skin_tone(emoji, @default_skin_tone) %>
                          </button>
                        <% end %>
                      </div>
                    <% end %>
                  </div>
                </div>
              <% end %>

              <form phx-submit="send_message" class="space-y-3">
                <textarea
                  name="message"
                  rows="3"
                  phx-change="update_message"
                  placeholder={if @selected_user, do: "Message #{@selected_user.name}...", else: "Send a message"}
                  class="w-full border border-gray-300 rounded-lg px-3 py-3 text-sm focus:outline-none resize-none transition-colors"
                  id="message-input"
                ><%= @message_input %></textarea>

                <!-- Action Icons -->
                <div class="flex items-center justify-between">
                  <div class="flex items-center space-x-3">
                    <!-- Upload Picture -->
                    <button type="button" class="text-gray-400 hover:text-gray-600 transition-colors" title="Upload image">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                      </svg>
                    </button>

                    <!-- GIF via Tenor API -->
                    <button type="button" phx-click="toggle_gif_picker" class={"text-gray-400 hover:text-gray-600 transition-colors #{if @gif_picker_open, do: "text-emerald-500"}"} title="Send GIF">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                      </svg>
                    </button>

                    <!-- Emoji Picker -->
                    <button type="button" phx-click="toggle_emoji_picker" class={"text-gray-400 hover:text-gray-600 transition-colors #{if @emoji_picker_open, do: "text-emerald-500"}"} title="Add emoji">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </button>

                    <!-- Attachment -->
                    <button type="button" class="text-gray-400 hover:text-gray-600 transition-colors" title="Attach file">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13" />
                      </svg>
                    </button>
                  </div>

                  <!-- Send Button -->
                  <button
                    type="submit"
                    class="bg-emerald-500 text-white rounded-lg p-2 hover:bg-emerald-600 transition-colors flex items-center justify-center"
                  >
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                    </svg>
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Chat Button (always visible, always in same position) -->
        <button
          phx-click="toggle_chat"
          class="bg-emerald-500 hover:bg-emerald-600 text-white rounded-full p-4 shadow-lg transition-all duration-300 hover:scale-110"
          style="animation: pulse-ring 2s infinite;"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4 8-9 8a9.959 9.959 0 01-5.7-1.8l-3.9.7c-.4.1-.8-.3-.7-.7l.7-3.9A9.959 9.959 0 013 12c0-4.418 4-8 9-8s9 3.582 9 8z" />
          </svg>
        </button>
      </div>

      <!-- Custom Styles and JavaScript -->
      <style>
        @keyframes pulse-ring {
          0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4); }
          70% { box-shadow: 0 0 0 20px rgba(16, 185, 129, 0); }
          100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        @keyframes fade-in {
          from { opacity: 0; transform: translateY(20px) scale(0.95); }
          to { opacity: 1; transform: translateY(0) scale(1); }
        }

        @keyframes slide-in {
          from { opacity: 0; transform: translateX(20px); }
          to { opacity: 1; transform: translateX(0); }
        }

        .animate-fade-in {
          animation: fade-in 0.3s ease-out;
        }

        .animate-slide-in {
          animation: slide-in 0.3s ease-out;
        }

        .scrollbar-hide {
          -ms-overflow-style: none;
          scrollbar-width: none;
        }

        .scrollbar-hide::-webkit-scrollbar {
          display: none;
        }
      </style>

      <script>
        let shouldFocusTextarea = false;

        window.addEventListener('DOMContentLoaded', function() {
          setupTextareaHandlers();
        });

        function setupTextareaHandlers() {
          const textarea = document.getElementById('message-input');
          if (textarea) {
            // Add enter key handler if not already added
            if (!textarea.hasAttribute('data-enter-listener')) {
              textarea.setAttribute('data-enter-listener', 'true');
              textarea.addEventListener('keydown', function(event) {
                if (event.key === 'Enter' && !event.shiftKey) {
                  event.preventDefault();
                  const form = this.closest('form');
                  if (form) {
                    const submitEvent = new Event('submit', { bubbles: true, cancelable: true });
                    form.dispatchEvent(submitEvent);
                  }
                }
              });
            }

            // Focus textarea if flag is set (after emoji selection)
            if (shouldFocusTextarea) {
              textarea.focus();
              // Move cursor to end of text
              const length = textarea.value.length;
              textarea.setSelectionRange(length, length);
              shouldFocusTextarea = false;
            }
          }
        }

        // Handle emoji button clicks to set focus flag
        document.addEventListener('click', function(event) {
          // Check if clicked element is an emoji button
          if (event.target.closest('[phx-click="select_emoji"]')) {
            shouldFocusTextarea = true;
          }

          // Close emoji picker when clicking outside of it
          const emojiPicker = document.querySelector('.emoji-picker-container');
          const emojiButton = document.querySelector('[phx-click="toggle_emoji_picker"]');

          if (emojiPicker && !emojiPicker.contains(event.target) && !emojiButton?.contains(event.target)) {
            // If emoji picker is open and click is outside, close it
            const isEmojiPickerOpen = emojiPicker.style.display !== 'none' && !emojiPicker.classList.contains('hidden');
            if (isEmojiPickerOpen) {
              // Trigger the toggle to close the picker
              if (emojiButton) {
                emojiButton.click();
              }
            }
          }
        });

        // Re-setup handlers and handle focus after LiveView updates
        document.addEventListener('phx:update', function() {
          setupTextareaHandlers();
        });
      </script>
    </div>
    """
  end
end
