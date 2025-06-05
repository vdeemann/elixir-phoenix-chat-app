defmodule ChatAppWeb.ChatLive do
  use ChatAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:chat_open, false)
     |> assign(:messages, [])
     |> assign(:message_input, "")}
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
    <div class="min-h-screen bg-gray-50 relative">
      <!-- Simple Main Content -->
      <div class="container mx-auto px-4 py-8">
        <div class="text-center">
          <h1 class="text-4xl font-bold text-gray-900 mb-4">Welcome</h1>
          <p class="text-gray-600 mb-8">This is your application. The chat widget is available in the bottom-right corner.</p>

          <div class="bg-white rounded-lg shadow-sm border p-8 max-w-md mx-auto">
            <h2 class="text-lg font-semibold text-gray-900 mb-2">Need Help?</h2>
            <p class="text-gray-600 mb-4">Click the green chat button to get started!</p>
            <button
              phx-click="toggle_chat"
              class="bg-emerald-500 text-white px-6 py-2 rounded-lg hover:bg-emerald-600 transition-colors"
            >
              Open Chat
            </button>
          </div>
        </div>
      </div>

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
              <div class="flex items-center">
                <div class="w-10 h-10 bg-white rounded-full flex items-center justify-center mr-3">
                  <div class="w-6 h-6 bg-emerald-500 rounded-full flex items-center justify-center">
                    <svg class="h-4 w-4 text-white" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                    </svg>
                  </div>
                </div>
                <div>
                  <h3 class="font-semibold text-base">Hi there 👋</h3>
                  <p class="text-sm opacity-90">How can we help?</p>
                </div>
              </div>
              <button phx-click="close_chat" class="text-white hover:text-gray-200 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <!-- Messages Area -->
            <div class="flex-1 p-4 overflow-y-auto space-y-4 bg-gray-50">
              <!-- Welcome message -->
              <div class="flex items-start space-x-3">
                <div class="w-8 h-8 bg-emerald-100 rounded-full flex items-center justify-center flex-shrink-0">
                  <span class="text-emerald-600 text-xs font-semibold">S</span>
                </div>
                <div class="bg-white rounded-lg p-3 max-w-xs shadow-sm">
                  <p class="text-sm text-gray-800">We typically reply in a few hours</p>
                </div>
              </div>

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

            <!-- Status Bar -->
            <div class="px-4 py-3 border-t bg-gray-50">
              <div class="flex items-center text-xs text-gray-600">
                <div class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></div>
                <span class="font-medium">Status: All Systems Operational</span>
              </div>
              <div class="text-xs text-gray-500 mt-1">
                Updated Jun 5, 15:06 UTC
              </div>
            </div>

            <!-- Message Input -->
            <div class="p-4 border-t bg-white rounded-b-xl">
              <form phx-submit="send_message" class="flex space-x-3">
                <input
                  type="text"
                  name="message"
                  value={@message_input}
                  phx-change="update_message"
                  placeholder="Send us a message"
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
