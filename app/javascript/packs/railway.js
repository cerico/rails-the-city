import 'core-js/stable'
import 'regenerator-runtime/runtime'

import WebpackerReact from 'webpacker-react'
import Counter from 'components/Counter'
import Railway from 'components/Railway'

WebpackerReact.setup({ Counter, Railway })
