import rand
import strconv
import ui
import clipboard

[heap]
struct App {
mut:
	m_str_key string

	m_lab_key &ui.Label
	m_btn_gen &ui.Button
	m_btn_cpy &ui.Button

	m_row &ui.Stack
	m_col &ui.Stack

	m_win &ui.Window
}

fn main() {
	mut app := &App{
		m_str_key: ''
		m_lab_key: ui.label(text: 'Key: ')
		m_btn_gen: 0
		m_btn_cpy: 0
		m_row: 0
		m_col: 0
		m_win: 0
	}

	app.m_btn_gen = ui.button(text: 'Generate Key', on_click: app.click_btn_gen)
	app.m_btn_cpy = ui.button(text: 'Copy to Clipboard', on_click: app.click_btn_cpy)

	app.m_row = ui.row(
		widths: ui.stretch
		heights: ui.stretch
		children: [app.m_btn_gen, app.m_btn_cpy]
	)
	app.m_col = ui.column(margin: ui.Margin{10, 0, 0, 0}, children: [app.m_lab_key, app.m_row])

	app.m_win = ui.window(
		width: 240
		height: 48
		title: 'V Win95 Keygen'
		children: [app.m_col]
	)

	ui.run(app.m_win)
}

fn (mut app App) click_btn_gen(btn &ui.Button) {
	i_day := rand.u32() % 367
	i_year := (95 + rand.u32() % 8) % 100
	i_unchk := rand.u32() % 100000

	mut array_mod7 := [5]u32{}
	mut i_count := u32(0)

	for {
		i_count = 0
		array_mod7 = [5]u32{}

		array_length := 5
		mut i := 0
		for i < array_length {
			array_mod7[i] = rand.u32() % 10
			i_count += array_mod7[i]

			i++
		}

		if i_count % 7 == 0 {
			break
		}
	}

	mut i_mod7 := u32(0)

	for number in array_mod7 {
		i_mod7 *= 10
		i_mod7 += number
	}

	app.m_str_key = strconv.v_sprintf('%03d%02d-OEM-00%05d-%05d', i_day, i_year, i_mod7,
		i_unchk)
	app.m_lab_key.set_text('Key: ' + app.m_str_key)
}

fn (mut app App) click_btn_cpy(btn &ui.Button) {
	mut cb := clipboard.new()

	cb.copy(app.m_str_key)
}
