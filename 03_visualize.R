library(ggplot2)
library(viridis)

source("~/R/daylight/02_parse_data.R")
df <- read.csv("~/R/daylight/data/kyiv.csv", stringsAsFactors = F)
df <- parse_data(df)

png(filename = "~/R/daylight/daylight.png", 
    width = 1200, height = 1000, type = "cairo-png")

ggplot(df)+
  geom_linerange(aes(date, ymin = start, ymax = end,
                     color = end - start), size = 1.5)+
  geom_text(data = df[df$date == min(df$date),],
                  aes(x = date, y = start, label = "початок світлового дня",
                      family = "Ubuntu Condensed", fontface = "plain"),
                  hjust = 0, vjust = 5, colour = "#5D646F", size = 5)+
  geom_text(data = df[df$date == min(df$date),],
            aes(x = date, y = end, label = "кінець світлового дня",
                family = "Ubuntu Condensed", fontface = "plain"),
            hjust = 0, vjust = -5, colour = "#5D646F", size = 5)+
  geom_text(data = df[df$date == as.Date("2016-03-27"),],
            aes(x = date, y = end, label = "перехід на літній час",
                family = "Ubuntu Condensed", fontface = "plain"),
            hjust = 0, vjust = -4.5, colour = "#5D646F", size = 5)+
  geom_text(data = df[df$date == as.Date("2016-10-30"),],
            aes(x = date, y = end, label = "перехід на зимовий час",
                family = "Ubuntu Condensed", fontface = "plain"),
            hjust = 0, vjust = -4.5, colour = "#5D646F", size = 5)+
  scale_color_viridis(begin = 0.4, end = 0.7, alpha = 0.1)+
  scale_x_date(name = NULL, breaks = as.Date(c("2016-03-01",
                                               "2016-06-01", "2016-09-01",
                                               "2016-12-01")), 
               date_labels = "%B", minor_breaks = NULL)+
  scale_y_datetime(date_breaks = "2 hours", date_labels = "%H",
                   minor_breaks = NULL)+
  guides(color = guide_colorbar(title = "Тривалість світлового дня, годин", 
                                title.position = "top"))+
  labs(title = "Тривалість світлового дня у Києві",
       subtitle = "Найкоротший світловий день триває 8 годин, а найдовший - 16 годин 26 хвилин",
       caption = "Дані: timeanddate.com Візуалізація: textura.in.ua")+
  theme_minimal(base_family = "Ubuntu Condensed")+
  theme(text = element_text(family = "Ubuntu Condensed", color = "#3A3F4A", size = 14),
        legend.position = "top",
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.key.height = unit(3.5, "pt"),
        legend.key.width = unit(125, "pt"),
        axis.text.x = element_text(face = "plain", size = 14),
        axis.text.y = element_text(face = "plain", size = 14),
        axis.title = element_blank(),
        panel.grid.major = element_line(size = 0.25, linetype = "dotted", color = "#5D646F"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(face = "bold", size = 40, margin = margin(b = 20)),
        plot.subtitle = element_text(size = 22, margin = margin(b = 20)),
        plot.caption = element_text(size = 14, margin = margin(b = 10, t = 50), color = "#5D646F"),
        plot.background = element_rect(fill = "#EFF2F4"),
        plot.margin = unit(c(2, 2, 2, 2), "cm"))

dev.off()