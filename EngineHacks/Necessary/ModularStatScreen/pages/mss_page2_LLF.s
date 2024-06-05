.thumb
@draws the items screen
.include "mss_defs.s"
.include "new_draw_stats_box.asm"

.global MSS_page2
.type MSS_page2, %function


MSS_page2:

page_start

new_draw_stats_box showBallista=1

draw_items_text showBallista=1

page_end
