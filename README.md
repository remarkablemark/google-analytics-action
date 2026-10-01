# google-analytics-action

[![GitHub Release](https://img.shields.io/github/v/release/remarkablemark/google-analytics-action)](https://github.com/remarkablemark/google-analytics-action/releases)
[![test](https://github.com/remarkablemark/google-analytics-action/actions/workflows/test.yml/badge.svg)](https://github.com/remarkablemark/google-analytics-action/actions/workflows/test.yml)
[![lint](https://github.com/remarkablemark/google-analytics-action/actions/workflows/lint.yml/badge.svg)](https://github.com/remarkablemark/google-analytics-action/actions/workflows/lint.yml)

📊 Inject Google Analytics tracking code into an HTML file with GitHub Actions.

## Usage

```yaml
on: push
jobs:
  google-analytics-action:
    runs-on: ubuntu-latest
    steps:
      - name: Google Analytics Action
        uses: remarkablemark/google-analytics-action@v1
        with:
          html-path: dist/index.html
          measurement-id: G-XXXXXXXXXX
```

The action injects the [gtag.js](https://support.google.com/analytics/answer/9304153) script before the closing `</head>` tag. If `</head>` is not present, it falls back to inserting before `</body>`. The action fails if neither tag exists. It also fails if the file does not exist and skips injection if the snippet is already present.

## Inputs

See [action.yml](action.yml)

### `html-path`

**Required**: Path to the HTML file to modify:

```yaml
- uses: remarkablemark/google-analytics-action@v1
  with:
    html-path: dist/index.html
```

### `measurement-id`

**Required**: The Google Analytics ID (e.g., G-XXXXXXXXXX):

```yaml
- uses: remarkablemark/google-analytics-action@v1
  with:
    measurement-id: G-XXXXXXXXXX
```

## License

[MIT](LICENSE)
