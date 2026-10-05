# Seeds para o site de casamento Desi & João
# Popula PageSection com todo o conteúdo das páginas estáticas.
# Rode: bin/rails db:seed  (ou db:setup para recriar tudo)

puts "→ Limpando PageSection e PageImage..."
PageSection.destroy_all
PageImage.destroy_all

sections = [
  # ---------- HOME ----------
  { page: "home", name: "save_the_date", title: "Save the Date" },
  { page: "home", name: "name_1",       title: "Desi" },
  { page: "home", name: "name_2",       title: "João" },
  { page: "home", name: "date",         title: "19 de Junho, 2027" },
  { page: "home", name: "location",     title: "São Paulo · Brasil" },

  # ---------- INFO ----------
  { page: "info", name: "kicker",  title: "O Casamento" },
  { page: "info", name: "couple",  title: "Desi & João" },
  { page: "info", name: "intro",
    body: "Estamos muito felizes em compartilhar este dia especial com você. Abaixo, todos os detalhes para você se preparar e celebrar com a gente." },

  { page: "info", name: "card_date_title",       title: "Data & Hora" },
  { page: "info", name: "card_date_value",       title: "19 de Junho de 2027" },
  { page: "info", name: "card_date_sub",         title: "Sábado · 17h" },
  { page: "info", name: "card_venue_title",      title: "Local" },
  { page: "info", name: "card_venue_value",      title: "Capela da Sé" },
  { page: "info", name: "card_venue_sub",        title: "São Paulo · Brasil" },
  { page: "info", name: "card_reception_title",  title: "Recepção" },
  { page: "info", name: "card_reception_value",  title: "19h30" },
  { page: "info", name: "card_reception_sub",    title: "após a cerimônia" },

  { page: "info", name: "schedule_title", title: "Ordem da Cerimônia" },
  { page: "info", name: "schedule",
    body: %(<div class="space-y-4">
      <div class="flex items-baseline gap-4 border-b border-gold/20 pb-3"><span class="font-caps text-gold text-xs w-16 shrink-0">17h00</span><span class="font-serif text-cream text-lg">Recepção dos convidados</span></div>
      <div class="flex items-baseline gap-4 border-b border-gold/20 pb-3"><span class="font-caps text-gold text-xs w-16 shrink-0">17h30</span><span class="font-serif text-cream text-lg">Início da cerimônia</span></div>
      <div class="flex items-baseline gap-4 border-b border-gold/20 pb-3"><span class="font-caps text-gold text-xs w-16 shrink-0">18h15</span><span class="font-serif text-cream text-lg">Saída dos noivos & cumprimentos</span></div>
      <div class="flex items-baseline gap-4 border-b border-gold/20 pb-3"><span class="font-caps text-gold text-xs w-16 shrink-0">19h30</span><span class="font-serif text-cream text-lg">Início da recepção</span></div>
      <div class="flex items-baseline gap-4 border-b border-gold/20 pb-3"><span class="font-caps text-gold text-xs w-16 shrink-0">23h00</span><span class="font-serif text-cream text-lg">Brinde final & despedida</span></div>
    </div>) },

  { page: "info", name: "map_title", title: "Como Chegar" },
  { page: "info", name: "map_embed_url",
    title: "https://www.google.com/maps?q=Capela%20da%20Se%20Sao%20Paulo&output=embed" },

  { page: "info", name: "contact_title", title: "Contato" },
  { page: "info", name: "contact_body",
    body: "Dúvidas ou recados? Fale com os noivos:" },
  { page: "info", name: "contact_email", title: "desi.e.joao@gmail.com" },

  # ---------- TRAVEL ----------
  { page: "travel", name: "kicker", title: "Dicas de Viagem" },
  { page: "travel", name: "title",   title: "Para nossos convidados" },
  { page: "travel", name: "intro",
    body: "Reunimos algumas dicas para facilitar sua vinda a São Paulo e aproveitar a estadia." },

  { page: "travel", name: "stay_title", title: "Hospedagem" },
  { page: "travel", name: "stay_body",
    body: "Sugerimos hotéis na região central, próximos ao local da cerimônia. Há opções para todos os orçamentos a partir de R$ 250/dia." },

  { page: "travel", name: "flights_title", title: "Voos" },
  { page: "travel", name: "flights_body",
    body: "O aeroporto mais próximo é o Guarulhos (GRU), a cerca de 30 km do centro. Há também o Aeroporto de Congonhas (CGH), mais central." },

  { page: "travel", name: "transport_title", title: "Transporte" },
  { page: "travel", name: "transport_body",
    body: "Uber e táxi funcionam bem na cidade. Há também metrô com estações próximas aos pontos turísticos. Recomendamos não alugar carro (trânsito intenso)." },

  { page: "travel", name: "sights_title", title: "Passeios em SP" },
  { page: "travel", name: "sights_body",
    body: "Aproveite para visitar a Avenida Paulista, o MASP, o Parque do Ibirapuera e o Mercado Municipal." },

  { page: "travel", name: "gallery_title", title: "Galeria" },
]

puts "→ Criando #{sections.size} seções..."
sections.each do |attrs|
  PageSection.create!(attrs)
end

puts "→ Seed concluído: #{PageSection.count} seções em #{PageSection.distinct.pluck(:page).size} páginas."
