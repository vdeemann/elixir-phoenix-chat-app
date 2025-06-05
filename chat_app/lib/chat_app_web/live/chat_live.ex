defmodule ChatAppWeb.ChatLive do
  use ChatAppWeb, :live_view

  def mount(_params, _session, socket) do
    users = [
      %{id: 1, name: "Marcus", avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=32&h=32&fit=crop&crop=face"},
      %{id: 2, name: "Sarah", avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=32&h=32&fit=crop&crop=face"},
      %{id: 3, name: "Alex", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=32&h=32&fit=crop&crop=face"}
    ]

    {:ok,
     socket
     |> assign(:chat_open, false)
     |> assign(:messages, [])
     |> assign(:message_input, "")
     |> assign(:users, users)
     |> assign(:selected_user, nil)}
  end

  def handle_event("select_user", %{"user_id" => user_id}, socket) do
    user_id = String.to_integer(user_id)
    selected_user = Enum.find(socket.assigns.users, &(&1.id == user_id))

    {:noreply,
     socket
     |> assign(:selected_user, selected_user)
     |> assign(:messages, [])}  # Clear messages when switching users
  end

  def handle_event("toggle_chat", _params, socket) do
    {:noreply, assign(socket, :chat_open, !socket.assigns.chat_open)}
  end

  def handle_event("close_chat", _params, socket) do
    {:noreply, assign(socket, :chat_open, false)}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    if String.trim(message) != "" do
      user_message = %{
        id: :rand.uniform(10000),
        text: message,
        sender: :user,
        time: DateTime.utc_now()
      }

      # Generate bot response
      bot_responses = [
        "Thanks for reaching out! We typically reply within a few hours.",
        "I understand your question. Let me help you with that.",
        "That's a great question! Our team will get back to you shortly.",
        "We appreciate your message. How else can we assist you today?"
      ]

      bot_message = %{
        id: :rand.uniform(10000),
        text: Enum.random(bot_responses),
        sender: :bot,
        time: DateTime.add(DateTime.utc_now(), 1, :second)
      }

      {:noreply,
       socket
       |> assign(:messages, socket.assigns.messages ++ [user_message, bot_message])
       |> assign(:message_input, "")}
    else
      {:noreply, socket}
    end
  end

  def handle_event("update_message", %{"message" => message}, socket) do
    {:noreply, assign(socket, :message_input, message)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-white relative">

      <!-- Floating Chat Widget -->
      <div class="fixed bottom-6 right-6 z-50">
        <!-- Chat Button (when closed) -->
        <div class={"#{if @chat_open, do: "hidden", else: "block"}"}>
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

        <!-- Chat Window (when open) -->
        <div class={"#{if @chat_open, do: "block animate-fade-in", else: "hidden"}"}>
          <div class="bg-white rounded-xl shadow-2xl border w-80 h-[32rem] flex flex-col">
            <!-- Chat Header -->
            <div class="bg-emerald-500 text-white p-4 rounded-t-xl flex items-center justify-between">
              <div class="flex items-center space-x-2">
                <!-- User Avatars -->
                <div class="flex space-x-2">
                  <%= for user <- @users do %>
                    <button
                      phx-click="select_user"
                      phx-value-user_id={user.id}
                      class={"w-8 h-8 rounded-full border-2 transition-all duration-200 hover:scale-110 #{if @selected_user && @selected_user.id == user.id, do: "border-yellow-300 ring-2 ring-yellow-200", else: "border-white hover:border-gray-200"}"}
                    >
                      <img class="w-full h-full rounded-full object-cover" src={user.avatar} alt={user.name} />
                    </button>
                  <% end %>
                </div>

                <!-- Selected User Name -->
                <%= if @selected_user do %>
                  <div class="ml-2">
                    <p class="text-sm font-medium"><%= @selected_user.name %></p>
                    <p class="text-xs opacity-75">Online now</p>
                  </div>
                <% else %>
                  <div class="ml-2">
                    <p class="text-sm font-medium">Select a contact</p>
                    <p class="text-xs opacity-75">Choose someone to chat</p>
                  </div>
                <% end %>
              </div>
              <button phx-click="close_chat" class="text-white hover:text-gray-200 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <!-- Messages Area -->
            <div class="flex-1 p-4 overflow-y-auto space-y-4 bg-gray-50">
              <!-- Dynamic Messages -->
              <%= for message <- @messages do %>
                <%= if message.sender == :user do %>
                  <div class="flex justify-end animate-slide-in">
                    <div class="bg-emerald-500 text-white rounded-lg p-3 max-w-xs shadow-sm">
                      <p class="text-sm"><%= message.text %></p>
                    </div>
                  </div>
                <% else %>
                  <div class="flex items-start space-x-3 animate-slide-in">
                    <div class="w-8 h-8 bg-emerald-100 rounded-full flex items-center justify-center flex-shrink-0">
                      <span class="text-emerald-600 text-xs font-semibold">S</span>
                    </div>
                    <div class="bg-white rounded-lg p-3 max-w-xs shadow-sm">
                      <p class="text-sm text-gray-800"><%= message.text %></p>
                    </div>
                  </div>
                <% end %>
              <% end %>
            </div>

            <!-- Message Input -->
            <div class="p-4 border-t bg-white rounded-b-xl">
              <form phx-submit="send_message" class="flex space-x-3">
                <input
                  type="text"
                  name="message"
                  value={@message_input}
                  phx-change="update_message"
                  placeholder={if @selected_user, do: "Message #{@selected_user.name}...", else: "Send a message"}
                  class="flex-1 border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-colors"
                />
                <button
                  type="submit"
                  class="bg-emerald-500 text-white rounded-lg px-3 py-2 hover:bg-emerald-600 transition-colors flex items-center justify-center"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                  </svg>
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <!-- Custom Styles -->
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
      </style>
    </div>
    """
  end
end
